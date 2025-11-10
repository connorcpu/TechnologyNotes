.section .data
    buf:        .space 32        # Temporary buffer to store number strings for printing

test_fmt: 
    .asciz "Name: %s | Age: %u | Score: %d | Zero: %d | BigU: %u | BigS: %d | Empty:%s|Percent:%%\n"
    # Format string with %s, %d, %u and literal % characters

test_name: 
    .asciz "Dominykas"       # Name string to be used with %s
empty_str:
    .asciz ""                 # Empty string for testing %s

.section .text
    .globl main
    .globl myprintf

# ---------------------------------------------------------
# Main program
main:
    push %rbp                 # Save base pointer
    mov %rsp, %rbp            # Set base pointer for stack frame

    leaq test_fmt(%rip), %rdi  # Load address of format string into RDI (1st argument for myprintf)
    leaq test_name(%rip), %rsi # Load address of name string into RSI (2nd argument)
    mov $18, %rdx              # 3rd argument for myprintf: Age = 18
    mov $-42, %rcx             # 4th argument: Score = -42
    mov $0, %r8                # 5th argument: Zero
    mov $429496, %r9           # 6th argument: Big unsigned int

    sub $16, %rsp              # Allocate 16 bytes on stack (stack alignment)
    movq $-922337, (%rsp)      # 7th argument: Big signed int on stack
    movq $empty_str, 8(%rsp)   # 8th argument: Empty string on stack

    call myprintf              # Call our custom printf

    add $16, %rsp              # Restore stack pointer

    mov $60, %rax              # syscall number for exit
    xor %rdi, %rdi             # exit code 0
    syscall                    # terminate program

# ---------------------------------------------------------
# myprintf function
# Implements %s, %d, %u, %%
myprintf:
    push %rbp                  # Save caller's base pointer
    mov %rsp, %rbp             # Set new base pointer
    sub $32, %rsp              # Reserve stack space for local variables

    mov %rdi, %r12             # Save pointer to format string in R12
    lea 16(%rbp), %r13         # R13 points to first stack argument beyond registers

    # Save first 6 arguments (rsi, rdx, rcx, r8, r9) into stack
    mov %rsi, -8(%rbp)
    mov %rdx, -16(%rbp)
    mov %rcx, -24(%rbp)
    mov %r8,  -32(%rbp)
    mov %r9,  -40(%rbp)

    xor %r14, %r14             # Argument index counter = 0

.loop:
    movzbq (%r12), %rax        # Load next byte from format string (zero-extend to 64-bit)
    test %al, %al              # Test if it's null terminator
    je .done                   # End of string? Jump to done

    cmpb $'%', %al             # Check if current char is '%'
    jne .literal               # Not a '%', just print the char

    # Handle format specifier
    inc %r12                   # Move to next character after '%'
    movzbq (%r12), %rax        # Load specifier character

    cmpb $'s', %al
    je .case_s                 # If %s → jump to case_s
    cmpb $'d', %al
    je .case_d                 # If %d → jump to case_d
    cmpb $'u', %al
    je .case_u                 # If %u → jump to case_u
    cmpb $'%', %al
    je .case_percent           # If %% → print literal %

    # Unknown specifier → print as literal
    mov $'%', %rdi
    call print_char
    mov %rax, %rdi
    call print_char
    jmp .next

.case_s:
    call get_next_arg           # Get next argument (pointer to string)
    mov %rax, %rdi
    call print_string           # Print string
    jmp .next

.case_d:
    call get_next_arg           # Get next argument (signed int)
    mov %rax, %rdi
    call print_int              # Print signed integer
    jmp .next

.case_u:
    call get_next_arg           # Get next argument (unsigned int)
    mov %rax, %rdi
    call print_uint             # Print unsigned integer
    jmp .next

.case_percent:
    mov $'%', %rdi
    call print_char             # Print literal '%'
    jmp .next

.literal:
    mov %rax, %rdi
    call print_char             # Print literal character from format string

.next:
    inc %r12                    # Move to next character in format string
    jmp .loop                   # Repeat

.done:
    leave                        # Restore base pointer and stack pointer
    ret                          # Return to caller

# ---------------------------------------------------------
# Helper functions

print_raw:
    mov $1, %rax        # syscall number for write
    mov $1, %rdi        # file descriptor = stdout
    syscall             # write to stdout
    ret

print_string:
    push %rdi
    mov %rdi, %rsi
    xor %rcx, %rcx
.len_loop:
    cmpb $0, (%rsi)     # check for null terminator
    je .len_done
    inc %rcx
    inc %rsi
    jmp .len_loop
.len_done:
    mov %rcx, %rdx      # length of string
    pop %rsi
    call print_raw       # write string
    ret

print_char:
    sub $8, %rsp
    movb %dil, (%rsp)   # store char on stack
    mov %rsp, %rsi
    mov $1, %rdx
    call print_raw
    add $8, %rsp
    ret

print_uint:
    mov %rdi, %rax
    mov $buf+31, %rsi    # buffer end (store digits backwards)
    movb $0, (%rsi)      # null terminator
.u_loop:
    xor %rdx, %rdx
    mov $10, %rbx
    div %rbx             # divide RAX by 10; remainder in DL
    addb $'0', %dl       # convert remainder to ASCII
    dec %rsi
    mov %dl, (%rsi)      # store digit
    test %rax, %rax
    jnz .u_loop
    mov %rsi, %rdi
    call print_string
    ret

print_int:
    mov %rdi, %rax
    cmp $0, %rax
    jge .positive
    neg %rax
    push %rax
    mov $'-', %rdi
    call print_char       # print minus sign
    pop %rax
.positive:
    mov %rax, %rdi
    call print_uint       # print magnitude
    ret

get_next_arg:
    cmp $0, %r14
    je .arg_rsi
    cmp $1, %r14
    je .arg_rdx
    cmp $2, %r14
    je .arg_rcx
    cmp $3, %r14
    je .arg_r8
    cmp $4, %r14
    je .arg_r9
    # Arguments beyond 6 are on the stack
    mov %r14, %rax
    sub $5, %rax
    mov (%r13,%rax,8), %rax
    inc %r14
    ret

.arg_rsi:
    mov -8(%rbp), %rax
    inc %r14
    ret
.arg_rdx:
    mov -16(%rbp), %rax
    inc %r14
    ret
.arg_rcx:
    mov -24(%rbp), %rax
    inc %r14
    ret
.arg_r8:
    mov -32(%rbp), %rax
    inc %r14
    ret
.arg_r9:
    mov -40(%rbp), %rax
    inc %r14
    ret
