.global main

.section .bss
buffer: .skip 32
rsiv: .skip 8
rdxv: .skip 8
rcxv: .skip 8
r8v: .skip 8
r9v: .skip 8

.section .data
teststr: .asciz "my name is %s and i think i got an %d for my exam, test %r, also does %% work? "
test2: .asciz "I wanna try the negative number %d, and the unsigned number %u."
test3: .asciz " In adition i'd like to try this: %d, %d, %d, %u, %u, %u, %s %%%% :) (hopefully)."
test4: .asciz "2 to the power of 64: %u, %u, %s %s %d %d %u %s."
//teststr: .string "my name is %s and i think i got an %i for my exam, test %r, also does %% work?"
//teststr: .asciz "hello world\n"
name: .asciz "connor"
testsubstr: .asciz "aoetuhnsaoeuhtns"
dominic: .asciz "dominic"

.section .text

main:
   push %rbp
   mov %rsp, %rbp

   //test 1
   leaq teststr, %rdi
   leaq name, %rsi
   mov $5, %rdx
   call my_printf

   //test 2
   leaq test2, %rdi
   mov $-300, %rsi 
   mov $1300, %rdx 
   call my_printf

   //test 3
   leaq test3, %rdi 
   mov $-257, %rsi 
   mov $513, %rdx 
   mov $-9223372036854775808, %rcx 
   mov $2049, %r8 
   mov $4097, %r9
   leaq name, %rax
   push %rax 
   push $8194

   call my_printf

  // pop %rax
  // pop %rax

   leaq test4, %rdi
   mov $18446744073709551615, %rsi
   mov $-5, %rdx
   leaq testsubstr, %rcx 
   leaq name, %r8
   mov $0, %r9
   leaq dominic, %rax
   push %rax
   pushq $-1
   pushq $0

   call my_printf

  /* pop %rax
   pop %rax
   pop %rax*/

   movq %rbp, %rsp
   pop %rbp
   
   mov $60, %rax
   xor %rdx, %rdx
   syscall

my_printf:
   push %rbp
   mov %rsp, %rbp
   push %r12
   push %r13
   push %r14
   push %r15

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
   lea 16(%rbp), %r13

   mov %rsi, rsiv
   mov %rdx, rdxv
   mov %rcx, rcxv
   mov %r8, r8v
   mov %r9, r9v

   xor %r14, %r14

#loop through string
   xor %rcx, %rcx
   //%rdi is string pointer 
   mov %rdi, %r12
   .jmpLabel:
//index %rcx into string
   mov (%r12, %rcx, 1), %rax
   cmpb $'%', %al
   je .percentage
   movb (%r12, %rcx, 1), %dil
   push %rcx
   push %rax
   call putchar
   pop %rax
   pop %rcx

   
   inc %rcx
   mov (%r12, %rcx, 1), %r15
   cmpb $0x00, %r15b
   je .done
   jmp .jmpLabel

   .done:

   pop %r15 
   pop %r14 
   pop %r13
   pop %r12

   movq %rbp, %rsp
   pop %rbp
   ret
   
   #break loop on % else putchar it

   #if it's % do everysingle case, (puts, i2a, u2a, %)
   .percentage:
   inc %rcx
   cmpb $'%', (%r12, %rcx, 1)
   je .percentageChar

   cmpb $'u', (%r12, %rcx, 1)
   je .unsigned

   cmpb $'d', (%r12, %rcx, 1)
   je .signed

   cmpb $'s', (%r12, %rcx, 1)
   je .string 

   mov (%r12, %rcx, 1), %rdi

   push %rcx 
   push %rax
   call putchar
   pop %rax 
   pop %rcx

   inc %rcx
   jmp .jmpLabel
   
   .percentageChar:
   mov $'%', %rdi

   push %rax 
   push %rcx 
   call putchar
   pop %rcx 
   pop %rax 

   inc %rcx
   jmp .jmpLabel

   .unsigned:
   mov %r13, %rdi 
   mov %r14, %rsi

   call getNextArg

   inc %r14
   mov %rax, %rdi
   push %rdx 
   push %rsi 
   push %rax
   push %rax
   call u2a
   pop %rdx 
   pop %rsi 
   pop %rax 
   pop %rax

   inc %rcx
   jmp .jmpLabel

   .signed:
   mov %r13, %rdi 
   mov %r14, %rsi
   call getNextArg
   inc %r14
   mov %rax, %rdi

   push %rax
   push %rax
   call i2a
   pop %rax
   pop %rax

   inc %rcx
   jmp .jmpLabel

   .string:
   mov %r13, %rdi 
   mov %r14, %rsi

   call getNextArg

   inc %r14
   mov %rax, %rdi
   push %rax
   push %rcx 
   call puts
   pop %rcx 
   pop %rax

   inc %rcx 
   jmp .jmpLabel
   
puts:
   push %rbp
   mov %rsp, %rbp
   push %r12
   push %r12
   
   mov %rdi, %r12
   xor %rcx, %rcx
   .putsLabel:
   movb (%r12, %rcx, 1), %dil
   push %rax 
   push %rcx
   call putchar
   pop %rcx 
   pop %rax

   inc %rcx
   movb (%r12, %rcx, 1), %dil
   //cmpb $0x00, (%r12, %rcx, 1)
   cmpb $0, %dil
   jne .putsLabel

   pop %r12
   pop %r12
   movq %rbp, %rsp
   pop %rbp
   ret

putchar:
   push %rbp
   mov %rsp, %rbp
   push %r12
   
   push %rdi
   mov %rsp, %rsi

   //print 1 char, with sys_write, to file handle 1
   mov $1, %rdx 
   mov $1, %rax
   mov $1, %rdi
   syscall

   pop %rdi

   pop %r12

   movq %rbp, %rsp
   pop %rbp
   ret

getNextArg:
   push %rbp
   mov %rsp, %rbp

   push %r13
   push %r14

   mov %rdi, %r13
   mov %rsi, %r14
   
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

   jmp .doneNext


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

   pop %r14
   pop %r13

   movq %rbp, %rsp
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
   push %rcx 
   call putchar
   pop %rcx

   pop %rax

.positive:
   mov %rax, %rdi
   push %rdx 
   push %rsi 
   push %rax
   push %rax
   call u2a
   pop %rdx 
   pop %rsi 
   pop %rax 
   pop %rax

   movq %rbp, %rsp
   pop %rbp
   ret
   
u2a:
   push %rbp
   mov %rsp, %rbp
   push %rbx
   push %rbx

   //reset buffer to empty
   mov $buffer, %rsi 
   movq $0, (%rsi) 
   movq $0, 8(%rsi) 
   movq $0, 16(%rsi) 
   movq $0, 24(%rsi) 

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
   

   push %rax
   push %rcx
   call puts
   pop %rcx 
   pop %rax


   pop %rbx
   pop %rbx
   movq %rbp, %rsp
   pop %rbp
   ret
