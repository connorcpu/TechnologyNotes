.global main

.section .bss
buffer: .skip 32
rsiv: .skip 8
rdxv: .skip 8
rcxv: .skip 8
r8v: .skip 8
r9v: .skip 8

.section .data
teststr: .asciz "my name is %s and i think i got an %d for my exam, test %r, also does %% work?"
//teststr: .string "my name is %s and i think i got an %i for my exam, test %r, also does %% work?"
//teststr: .asciz "hello world\n"
name: .asciz "connor"


.section .text

main:
   push %rbp
   mov %rsp, %rsp
   leaq teststr, %rdi
   leaq name, %rsi
   mov $5, %rdx
   call my_printf

   pop %rbp
   
   mov $60, %rax
   xor %rdx, %rdx
   syscall

my_printf:
   push %rbp
   mov %rsp, %rbp
   //not a fan of doing it this way but ig it works best here
 /*  sub $32, %rsp 
   lea 16(%rbp), %r13
# store arguments to be used by getNextArg
   mov %rsi, -8(%rbp)
   mov %rdx, -16(%rbp)
   mov %rcx, -24(%rbp)
   mov %r8, -32(%rbp)
   mov %r9, -40(%rbp) */

   //funcy shit
   mov 8(%rbp), %r13

   mov %rsi, rsiv
   mov %rdx, rdxv
   mov %rcx, rcxv
   mov %r8, r8v
   mov %r9, r9v

   xor %r14, %r14

#loop through string
   xor %rcx, %rcx
   //%rdi is string pointer 
   mov %rdi, %r11
   .jmpLabel:
//index %rcx into string
   mov (%r11, %rcx, 1), %rax
   cmpb $'%', %al
   je .percentage
   movb (%r11, %rcx, 1), %dil
   call putchar
   
   inc %rcx
   mov (%r11, %rcx, 1), %r15
   cmpb $0x00, %r15b
   je .done
   jmp .jmpLabel

   .done:
   pop %rbp
   ret
   
   #break loop on % else putchar it

   #if it's % do everysingle case, (puts, i2a, u2a, %)
   .percentage:
   inc %rcx
   cmpb $'%', (%r11, %rcx, 1)
   je .percentageChar

   cmpb $'u', (%r11, %rcx, 1)
   je .unsigned

   cmpb $'d', (%r11, %rcx, 1)
   je .signed

   cmpb $'s', (%r11, %rcx, 1)
   je .string 

   mov (%r11, %rcx, 1), %rdi
   call putchar

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

   inc %rcx
   jmp .jmpLabel

   .signed:
   call getNextArg
   mov %rax, %rdi
   call i2a

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
   push %rdi
   push %r11
   
   mov %rdi, %r11
   xor %rcx, %rcx
   .putsLabel:
   movb (%r11, %rcx, 1), %dil
   call putchar
   inc %rcx
   cmpb $0x00, (%rdi, %rcx, 1)
   je .putsLabel

   pop %r11
   pop %rdi
   pop %rcx
   pop %rbp
   ret

putchar:
   push %rbp
   mov %rsp, %rbp
   push %rdi
   push %rsi
   push %rax
   push %rdx
   push %rcx
   push %r11
   
   push %rdi
   mov %rsp, %rsi

   //print 1 char, with sys_write, to file handle 1
   mov $1, %rdx 
   mov $1, %rax
   mov $1, %rdi
   syscall

   pop %rdi

   pop %r11
   pop %rcx
   pop %rdx
   pop %rax
   pop %rsi
   pop %rdi

   pop %rbp
   ret

getNextArg:
   push %rbp
   mov %rsp, %rbp
   
   cmp $0, %r14
   je .rsil
   
   cmp $1, %r14
   je .rdxl

   cmp $2, %r14
   je .rcxl

   cmp $3, %r14
   je .r8l

   cmp $4, %r14
   je .r9l
   
   //arguments are on the stack
   sub $5, %r14
   lea (%r13, %r14, 8), %rax
   mov (%rax), %rax
   add $5, %r14


.rsil:
   mov rsiv, %rax
   jmp .doneNext
.rdxl:
   mov rdxv, %rax
   jmp .doneNext
.rcxl:
   mov rcxv, %rax
   jmp .doneNext
.r8l:
   mov r8v, %rax
   jmp .doneNext
.r9l:
   mov r9v, %rax
   jmp .doneNext

.doneNext:
   inc %r14

   pop %rbp
   ret

i2a:
   push %rbp
   mov %rsp, %rbp

   mov %rdi, %rax
   cmp $0, %rax
   jge .positive 
   neg %rax 
   push %rax
   mov $'-', %rdi
   call putchar
   pop %rax

.positive:
   mov %rax, %rdi
   call u2a

   pop %rbp
   ret
   
u2a:
   push %rbp
   mov %rsp, %rbp
   push %rdx
   push %rbx

   //yada yada, algorithm must run backwards so but backwards in the buffer, print forwards
   mov %rdi, %rax
   mov $buffer+31, %rsi 
   movb $0, (%rsi) #should already be 0 but be fucking sure cause multiple ints might get printed
.u2aloop:
   xor %rdx, %rdx 
   mov $10, %rbx
   div %rbx #div is fucking retarded in this but ig it works sorta well in this case? 
   addb $'0', %dl #add '0' because of how ascii works
   dec %rsi  #array go backwards :|
   mov %dl, (%rsi) #put in array
   test %rax, %rax #is there more in rax
   jnz .u2aloop
   mov %rsi, %rdi #absolute genius this line, fuck the start of the buffer, just leave poiner at start of digits, magnificent
   call puts


   pop %rbx
   pop %rdx
   pop %rbp
   ret
