#include "shader.h"

#include <framework/disable_all_warnings.h>
DISABLE_WARNINGS_PUSH()
#include <fmt/format.h>
DISABLE_WARNINGS_POP()

#include <cassert>
#include <fstream>
#include <iostream>
#include <regex>
#include <sstream>
#include <string>
#if __has_include("framework/exam_crypt.h")
#include <framework/exam_crypt.h>
#endif


static constexpr GLuint invalid = 0xFFFFFFFF;





namespace {

static std::string loadShaderFileContents(const std::filesystem::path& filePath)
{
    std::ifstream file(filePath, std::ios::binary);
    if (!file.is_open()) {
        throw ShaderLoadingException(fmt::format("Failed to open shader file: {}", filePath.string()));
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string raw = buffer.str();

#if __has_include("framework/exam_crypt.h")

    if (!exam_crypt::looksEncrypted(raw))
        return raw;

    std::string decrypted;
    if (!exam_crypt::decrypt(raw, decrypted)) {
        throw ShaderLoadingException(fmt::format("File {} is damaged", filePath.string()));
    }
    return decrypted;
#else
    return raw;
#endif
}

struct ShaderSource {
    std::string source;
    std::vector<std::filesystem::path> sourceFiles;
};

constexpr int32_t MAX_INCLUDE_DEPTH = 8;

// Recursively resolves #include directives in GLSL files
void appendResolved(const std::filesystem::path& filePath, std::string& out,
    std::vector<std::filesystem::path>& sourceFiles, int32_t depth)
{
    if (depth > MAX_INCLUDE_DEPTH) {
        throw ShaderLoadingException(fmt::format("Include depth exceeded while processing {} (cyclic #include?)", filePath.string()));
    }

    const size_t thisSourceIdx = sourceFiles.size();
    sourceFiles.push_back(filePath);

    static const std::regex includePattern(R"(^[ \t]*#[ \t]*include[ \t]+\"([^\"]+)\"[ \t]*$)");

    std::istringstream lines(loadShaderFileContents(filePath));
    std::string line;
    int32_t lineNumber = 0;

    while (std::getline(lines, line)) {
        lineNumber++;

        if (!line.empty() && line.back() == '\r') {
            line.pop_back();
        }

        std::smatch match;
        if (!std::regex_match(line, match, includePattern)) {
            out += line;
            out += '\n';
            continue;
        }

        const std::filesystem::path includePath = filePath.parent_path() / match[1].str();
        out += "#line 1 " + std::to_string(sourceFiles.size()) + "\n";
        appendResolved(includePath, out, sourceFiles, depth + 1);
        out += "#line " + std::to_string(lineNumber + 1) + " " + std::to_string(thisSourceIdx) + "\n";
    }
}

ShaderSource loadShaderSource(const std::filesystem::path& shaderFile)
{
    ShaderSource result;
    appendResolved(shaderFile, result.source, result.sourceFiles, 0);
    return result;
}

void printSourceFileMapping(const ShaderSource& shaderSource)
{
    if (shaderSource.sourceFiles.size() <= 1UL) {
        return;
    }
    std::cerr << "  The number before the line number in the errors above identifies the file:" << std::endl;
    for (size_t sourceIdx = 0UL; sourceIdx < shaderSource.sourceFiles.size(); sourceIdx++) {
        std::cerr << "    " << sourceIdx << " = " << shaderSource.sourceFiles[sourceIdx].filename().string() << std::endl;
    }
}

// Single unified error log query for both Shader and Program objects
template <typename GetIv, typename GetLog>
bool checkGLErrors(GLuint id, GLenum statusType, GetIv getIv, GetLog getLog)
{
    GLint success;
    getIv(id, statusType, &success);
    if (!success) {
        GLint logLength = 0;
        getIv(id, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            std::string logBuffer(static_cast<size_t>(logLength), '\0');
            getLog(id, logLength, nullptr, logBuffer.data());
            std::cerr << logBuffer << std::endl;
        }
        return false;
    }
    return true;
}

inline bool checkShaderErrors(GLuint shader)
{
    return checkGLErrors(shader, GL_COMPILE_STATUS, glGetShaderiv, glGetShaderInfoLog);
}

inline bool checkProgramErrors(GLuint program)
{
    return checkGLErrors(program, GL_LINK_STATUS, glGetProgramiv, glGetProgramInfoLog);
}
} // anonymous namespace

// --- Shader ---

Shader::Shader(GLuint program)
    : m_program(program)
{
}
Shader::Shader()
    : m_program(invalid)
{
}

Shader::Shader(Shader&& other) noexcept
{
    m_program = other.m_program;
    other.m_program = invalid;
}

Shader::~Shader()
{
    if (m_program != invalid)
        glDeleteProgram(m_program);
}

Shader& Shader::operator=(Shader&& other) noexcept
{
    if (this != &other) {
        if (m_program != invalid)
            glDeleteProgram(m_program);

        m_program = other.m_program;
        other.m_program = invalid;
    }
    return *this;
}

void Shader::bind() const
{
    assert(m_program != invalid);
    glUseProgram(m_program);
}

void Shader::bindUniformBlock(const std::string& blockName, GLuint bindingLocation, GLuint uniformBlockBuffer) const
{
    GLuint blockIdx = glGetUniformBlockIndex(m_program, blockName.c_str());
    if (blockIdx != GL_INVALID_INDEX) {
        glUniformBlockBinding(m_program, blockIdx, bindingLocation);
        glBindBufferBase(GL_UNIFORM_BUFFER, bindingLocation, uniformBlockBuffer);
    } else {
        std::cout << "Could not bind uniform block " << blockName << " invalid name" << std::endl;
    }
}

GLuint Shader::getAttributeLocation(const std::string& name) const
{
    GLuint loc = glGetAttribLocation(m_program, name.c_str());
    if (loc == invalid) {
        std::cerr << "Warning : Could not find attribute " << name << std::endl;
    }
    return loc;
}

GLint Shader::getUniformLocation(const std::string& name) const
{
    GLint loc = glGetUniformLocation(m_program, name.c_str());
    if (loc == -1) {
        std::cerr << "Warning : Could not find uniform " << name << std::endl;
    }
    return loc;
}

// --- ShaderBuilder ---

ShaderBuilder::~ShaderBuilder()
{
    freeShaders();
}

ShaderBuilder& ShaderBuilder::addStage(GLuint shaderStage, const std::filesystem::path& shaderFile)
{
    if (!std::filesystem::exists(shaderFile)) {
        throw ShaderLoadingException(fmt::format("File {} does not exist", shaderFile.string()));
    }

    const ShaderSource shaderSource = loadShaderSource(shaderFile);

    try {
        return addStageFromSource(shaderStage, shaderSource.source, shaderFile.filename().string());
    } catch (const ShaderLoadingException&) {
        printSourceFileMapping(shaderSource);
        throw;
    }
}

ShaderBuilder& ShaderBuilder::addStageFromSource(GLuint shaderStage, const std::string& shaderSource, const std::string& debugName)
{
    const GLuint shader = glCreateShader(shaderStage);
    const char* shaderSourcePtr = shaderSource.c_str();
    glShaderSource(shader, 1, &shaderSourcePtr, nullptr);
    glCompileShader(shader);

    if (!checkShaderErrors(shader)) {
        glDeleteShader(shader);
        throw ShaderLoadingException(fmt::format("Failed to compile shader {}", debugName));
    }

    m_shaders.push_back(shader);
    return *this;
}

Shader ShaderBuilder::build()
{
    GLuint program = glCreateProgram();
    for (GLuint shader : m_shaders) {
        glAttachShader(program, shader);
    }
    glLinkProgram(program);

    if (!checkProgramErrors(program)) {
        glDeleteProgram(program);
        throw ShaderLoadingException("Shader program failed to link");
    }

    // Detach and clean up individual shader stage objects now that linking is complete
    freeShaders();

    return Shader(program);
}

Shader ShaderBuilder::build(const std::filesystem::path& vertexFile, const std::filesystem::path& fragmentFile)
{
    return ShaderBuilder {}
        .addStage(GL_VERTEX_SHADER, vertexFile)
        .addStage(GL_FRAGMENT_SHADER, fragmentFile)
        .build();
}

void ShaderBuilder::freeShaders()
{
    for (GLuint shader : m_shaders) {
        glDeleteShader(shader);
    }
    m_shaders.clear();
}