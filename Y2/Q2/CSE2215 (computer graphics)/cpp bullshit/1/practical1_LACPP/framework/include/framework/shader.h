#pragma once
#include "disable_all_warnings.h"
#include "opengl_includes.h"
DISABLE_WARNINGS_PUSH()
#include <glm/mat3x3.hpp>
#include <glm/mat4x4.hpp>
#include <glm/vec2.hpp>
#include <glm/vec3.hpp>
#include <glm/vec4.hpp>
DISABLE_WARNINGS_POP()
#include <exception>
#include <filesystem>
#include <string>
#include <vector>

struct ShaderLoadingException : public std::runtime_error {
    using std::runtime_error::runtime_error;
};

class Shader {
public:
    Shader();
    Shader(const Shader&) = delete;
    Shader(Shader&&) noexcept;
    ~Shader();

    Shader& operator=(const Shader&) = delete;
    Shader& operator=(Shader&&) noexcept;

    void bind() const;
    void bindUniformBlock(const std::string& blockName, GLuint bindingLocation, GLuint uniformBlockBuffer) const;
    GLuint getAttributeLocation(const std::string& name) const;
    GLint getUniformLocation(const std::string& name) const;

private:
    friend class ShaderBuilder;
    Shader(GLuint program);

    GLuint m_program;
};

class ShaderBuilder {
public:
    ShaderBuilder() = default;
    ShaderBuilder(const ShaderBuilder&) = delete;
    ShaderBuilder(ShaderBuilder&&) = default;
    ~ShaderBuilder();

    // Resolves #include directives recursively before compiling
    ShaderBuilder& addStage(GLuint shaderStage, const std::filesystem::path& shaderFile);

    // Compiles directly from raw in-memory GLSL string
    ShaderBuilder& addStageFromSource(GLuint shaderStage, const std::string& shaderSource, const std::string& debugName);

    Shader build();

    // One-line convenience helper to build a vertex + fragment shader pair with #include support
    static Shader build(const std::filesystem::path& vertexFile, const std::filesystem::path& fragmentFile);

private:
    void freeShaders();

    std::vector<GLuint> m_shaders;
};