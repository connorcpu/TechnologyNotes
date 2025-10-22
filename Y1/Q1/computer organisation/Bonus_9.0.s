.section .data

    fmt_change: .string "%d c %d\n"
    fmt_old:    .string "< %s\n"
    fmt_sep:    .string "---\n"
    fmt_new:    .string "> %s\n"
    counter:    .quad 0

    # continuous file texts (lines separated by '\n')
    file1_text:
        .string "hello world\nThis is a test\nGoodbye\n"
    file2_text:
        .string "Hello World\nThis   is a test\nGoodbye!\n"

.section .text
    .globl main
    .extern printf

# main: prepare pointers and flags, call diff
main:
    push %rbp
    movq %rsp, %rbp

    dec %rdi
#proccess argc argv 

xor %rcx, %rcx
xor %rdx, %rdx
.jmplabel:
    cmp $0, %rdi
    je .jmpcontinue

    mov (%rsi, %rdi, 8), %rax
    cmpb $'i', 1(%rax)
    je .setCase

    mov (%rsi, %rdi, 8), %rax
    cmpb $'B', 1(%rax)
    je .setBlank

    dec %rdi
    jmp .jmplabel

.setBlank:
   mov $1, %rcx
   dec %rdi
   jmp .jmplabel

.setCase:
   mov $1, %rdx
   dec %rdi
   jmp .jmplabel

.jmpcontinue:
    mov $file1_text, %rdi
    mov $file2_text, %rsi
    #mov $1, %rdx        # ignoreCase (1 to activate)
   # mov $0, %rcx        # ignoreBlank (1 to activate)
   
    push %rax
    push %r8
    push %r9
    push %r11

    call diff

    pop %r11
    pop %r9
    pop %r8
    pop %rax

    xor %eax, %eax
    mov %rbp, %rsp
	 pop %rbp
    ret

# diff:
# rdi = pointer to file1_text
# rsi = pointer to file2_text
# rdx = ignoreCase
# rcx = ignoreBlank
diff:
    push %rbp
    mov %rsp, %rbp
    sub $512, %rsp                # reserve buffers and locals (keeps 16B alignment although I couldnt care less)

    push %r12
    push %r13
    push %r14
    push %r15

    mov %rdi, -8(%rbp)            # save file1 pointer
    mov %rsi, -16(%rbp)           # save file2 pointer
    mov %rdx, -24(%rbp)           # save ignoreCase
    mov %rcx, -32(%rbp)           # save ignoreBlank

    lea -256(%rbp), %r12          # r12 = &buf1
    lea -512(%rbp), %r13          # r13 = &buf2

    mov -8(%rbp), %r14            # current pointer into file1
    mov -16(%rbp), %r15           # current pointer into file2

.loop_main:
    # Build next line from file1 into buf1
    mov %r14, %rdi
    cmp $0, %rdi
    je .s1_empty
    mov $0, %rax
    mov $0, %rcx
    mov %r12, %rsi
    mov $255, %rdx
.copy_line1:
    movzbq (%rdi,%rax,1), %r8
    cmpb $0, %r8b
    je .end_copy1
    cmpb $'\n', %r8b
    je .end_copy1
    movb %r8b, (%rsi,%rcx,1)
    inc %rax
    inc %rcx
    cmp %rdx, %rcx
    jb .copy_line1
.end_copy1:
    movb $0, (%rsi,%rcx,1)
    movzbq (%rdi,%rax,1), %r8
    cmpb $0, %r8b
    je .s1_set_zero
    cmpb $'\n', %r8b
    jne .s1_trunc
    lea 1(%rdi,%rax,1), %r14
    jmp .after_s1_prep
.s1_trunc:
    lea (%rdi,%rax,1), %r14
    jmp .after_s1_prep
.s1_set_zero:
    mov $0, %r14
    jmp .after_s1_prep
.s1_empty:
    movb $0, (%r12)
.after_s1_prep:

    # Build next line from file2 into buf2
    mov %r15, %rdi
    cmp $0, %rdi
    je .s2_empty
    mov $0, %rax
    mov $0, %rcx
    mov %r13, %rsi
    mov $255, %rdx
.copy_line2:
    movzbq (%rdi,%rax,1), %r9
    cmpb $0, %r9b
    je .end_copy2
    cmpb $'\n', %r9b
    je .end_copy2
    movb %r9b, (%rsi,%rcx,1)
    inc %rax
    inc %rcx
    cmp %rdx, %rcx
    jb .copy_line2
.end_copy2:
    movb $0, (%rsi,%rcx,1)
    movzbq (%rdi,%rax,1), %r9
    cmpb $0, %r9b
    je .s2_set_zero
    cmpb $'\n', %r9b
    jne .s2_trunc
    lea 1(%rdi,%rax,1), %r15
    jmp .after_s2_prep
.s2_trunc:
    lea (%rdi,%rax,1), %r15
    jmp .after_s2_prep
.s2_set_zero:
    mov $0, %r15
    jmp .after_s2_prep
.s2_empty:
    movb $0, (%r13)
.after_s2_prep:

    # If both files finished, done
    cmp $0, %r14
    jne .continue
    cmp $0, %r15
    jne .continue
    jmp .done

.continue:
    # Call str_compare on buf1 and buf2 with flags
    mov %r12, %rdi
    mov %r13, %rsi
    mov -24(%rbp), %rdx
    mov -32(%rbp), %rcx

    push %r8
    push %r9

    call str_compare

    pop %r9
    pop %r8
    
    cmp $0, %eax
    je .advance_and_loop

    # increment dedicated diff counter
    movq (counter), %r11
    incq %r11
    movq %r11, (counter)

    # print "N c N"
    movq %r11, %rsi
    movq %r11, %rdx
    mov $fmt_change, %rdi
    xor %eax, %eax
    call printf

    # print old line
    mov %r12, %rsi
    mov $fmt_old, %rdi
    xor %eax, %eax
    call printf

    # print separator
    mov $fmt_sep, %rdi
    xor %eax, %eax
    call printf

    # print new line
    mov %r13, %rsi
    mov $fmt_new, %rdi
    xor %eax, %eax
    call printf

.advance_and_loop:
    jmp .loop_main

.done:

    push %r15
    push %r14
    push %r13
    push %r12

    add $512, %rsp
    mov %rbp, %rsp
	 pop %rbp
    ret

# str_compare: rdi = s1, rsi = s2, rdx = ignoreCase, rcx = ignoreBlank
# returns eax = 0 if equal, 1 if different
str_compare:
    push %rbp
    mov %rsp, %rbp

.next_char_cmp:
    movzbq (%rdi), %r8
    movzbq (%rsi), %r9

    #don't uppercase spaces :facepalm:
#    cmp $0, %r8
 #   je .end_compare
  #  cmp $0, %r9
   # je .end_compare

    # Skip blanks if requested
    cmp $0, %rcx
    je .check_case_cmp
    cmp $' ', %r8
    je .inc_s1_cmp
    cmp $' ', %r9
    je .inc_s2_cmp
    jmp .check_case_cmp

.inc_s1_cmp:
    inc %rdi
    jmp .next_char_cmp
.inc_s2_cmp:
    inc %rsi
    jmp .next_char_cmp

.check_case_cmp:
    cmp $0, %rdx
    je .compare_cmp
    cmp $'A', %r8b
    jb .skip1_cmp
    cmp $'Z', %r8b
    ja .skip1_cmp
    add $32, %r8b
.skip1_cmp:
    cmp $'A', %r9b
    jb .compare_cmp
    cmp $'Z', %r9b
    ja .compare_cmp
    add $32, %r9b

.compare_cmp:
    cmp $0, %r8
    je .end_compare
    cmp $0, %r9
    je .end_compare

    cmp %r8b, %r9b
    jne .not_equal_cmp
    inc %rdi
    inc %rsi
    jmp .next_char_cmp

.end_compare:
    cmp $0, %r8
    jne .not_equal_cmp
    cmp $0, %r9
    jne .not_equal_cmp
    mov $0, %eax
    mov %rbp, %rsp
	 pop %rbp
    ret

.not_equal_cmp:
    mov $1, %eax
    mov %rbp, %rsp
	 pop %rbp
    ret
