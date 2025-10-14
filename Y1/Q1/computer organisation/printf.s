
.section .data
teststr: .asciz "my name is %s and i think i got an %i for my exam, test %r, also does %% work?"
name: .asciz "connor"

.section .bss
buffer: .space 256

.section .text

main:
   push %rbp
   mov %rsp, %rbp

   mov teststr, %rdi
   mov name, %rsi
   mov $5, %rdx
   call my_printf

   pop %rbp
   ret

my_printf:
   push %rbp
   mov %rsp, %rbp
   //not a fan of doing it this way but ig it works best here
   sub $32, %rsp 
   lea 16(%rbp), %r13
# store arguments to be used by getNextArg
   mov %rsi, -8(%rbp)
   mov %rdx, -16(%rbp)
   mov %rcx, -24(%rbp)
   mov %r8, -32(%rbp)
   mov %r9, -40(%rbp)
   xor %r14, %r14

#loop through string
   .jmpLabel:
   xor %rcx, %rcx
   //%rdi is string pointer 
   mov %rdi, %r11
//index %rcx into string
   mov (%r11, %rcx, 1), %rax
   cmpb %al, '%'
   je .percentage
   movb (%rdi, %rcx, 1), %dil
   call putchar
   
   inc %rcx
   mov (%r11, %rcx, 1), %r15
   cmpb $0x00, %r15b
   je .done
   jmp .jmpLabel

   .done:
   ret
   
   #break loop on % else putchar it

   #if it's % do everysingle case, (puts, i2a, u2a, %)
   .percentage:
   inc %rcx
   cmpb $'%', (%r11, %rcx, 1)
   je .percentageChar

   cmpb $'u', (%r11, %rcx, 1)
   je .unsigned

   cmpb $'i', (%r11, %rcx, 1)
   je .signed

   cmpb $'s', (%r11, %rcx, 1)
   je .string 

   inc %rcx
   jmp .jmpLabel
   
   .percentageChar:
   mov $'%', %rdi
   call putchar
   inc %rcx
   jmp .jmpLabel

   .unsigned:
   call getNextArg
   mov %rax, %rdi
   call u2a
   mov %rax, %rdi
   call puts

   inc %rcx
   jmp .jmpLabel

   .signed:
   call getNextArg
   mov %rax, %rdi
   call i2a
   mov %rax, %rdi
   call puts

   inc %rcx
   jmp .jmpLabel

   .string:
   call getNextArg
   mov %rax, %rdi
   call puts

   inc %rcx 
   jmp .jmpLabel
   
puts:
   push %rbp
   mov %rsp, %rbp
   push %rcx

   .putsLabel:
   xor %rcx, %rcx
   push %rdi
   movb (%rdi, %rcx, 1), %dil
   call putchar
   pop %rdi
   inc %rcx
   cmpb $0x00, (%rdi, %rcx, 1)
   je .putsLabel

   pop %rcx
   pop %rbp
   ret

putchar:
   push %rbp
   mov %rsp, %rbp
   
   mov %rdi, %rsi

   mov $1, %rax
   mov $1, %rdi
   syscall

   pop %rbp
   ret

getNextArg:
   cmp $4, %r14
   jle .registerArg

   mov %r14, %rax
   sub $5, %rax
   mov (%r13, %rax, 8), %rax
   inc %r14
   ret

   .registerArg:
   inc %r14
   mov (%r13, %r14, 8), %rax
   ret

i2a:
   push %rbp
   mov %rsp, %rbp
   
   cmp $0, %rdi
   je .zero
   xor %cl, %cl

.i2aloop:
   mov $10, %rcx
   mov %rdi, %rax
   div %rcx
   add $'0', %rdx
   mov buffer, %r12
   mov %dl, (%r12, %cl, 1)

   mov %rax, %rdi

   inc %cl
   cmpb $0, %cl
   jne .i2aloop

   mov buffer, %rax

   pop %rbp
   ret

u2a:
   push %rbp
   mov %rsp, %rbp

   cmp $0, (%rdi)
   je .zero

   pop %rbp
   ret

.zero:
   mov $0, rax
   pop %rbp
   ret


