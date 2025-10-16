.global sha1_chunk
.extern printf

.section .bss
a: .skip 4
b: .skip 2
c: .skip 4
d: .skip 4
e: .skip 4

f: .skip 4
k: .skip 4
h0_addr: .skip 8

.section .data
msg: .string "i: %i\n"
yo: .string "yoo\n"
i: .byte 16

.section .text

sha1_chunk:
   push %rbp
   movq %rsp, %rbp

   push %rax
   push %rbx
   push %rcx
   push %rdx
   
   //procces parameters
   movq %rdi, (h0_addr)
   
w_loop:
   xor %rcx, %rcx

   movb (i), %cl

   //w[i-3]
   movl -12(%rsi, %rcx, 4), %eax  
   //mov -3(%rsi, %rcx, 4), %eax  
   //w[i-8]
   movl -32(%rsi, %rcx, 4), %ebx
   //mov -8(%rsi, %rcx, 4), %ebx
   xorl %ebx, %eax
   //w[i-14] 
   movl -56(%rsi, %rcx, 4), %ebx
   //mov -14(%rsi, %rcx, 4), %ebx
   xorl %ebx, %eax
   //w[i-16]
   movl -64(%rsi, %rcx, 4), %ebx
   //mov -16(%rsi, %rcx, 4), %ebx
   xorl %ebx, %eax
   
   //leftshift DOES NOT LEFTSHIFT
   //oh and turns out theres a fucking roll instruction
   /*movl %eax, %edx
   shll $1, %eax
   shrl $31, %edx
   orl %edx, %eax*/
   roll $1, %eax

   //store back into w[i] :facepalm:
   movl %eax, (%rsi, %rcx, 4)

   incb %cl
   movb %cl, (i)
   cmpb $80, %cl
   //jnge w_loop
   jl w_loop

   //VALIDATED UNTIL HERE

w_loopDone:
   movb $0, (i)


   // initialize hash value for this chunk 
   movl (%rdi), %eax
   movl %eax, (a)
   movl 4(%rdi), %eax
   movl %eax, (b)
   movl 8(%rdi), %eax
   movl %eax, (c)
   movl 12(%rdi), %eax
   movl %eax, (d)
   movl 16(%rdi), %eax
   movl %eax, (e)

   jmp loop
   
   //main loop
loop:
   
   
   //i should probably be a register not a variable

   cmpb $80, (i)
   je _loopDone

   cmpb $20, (i)
   jb _sub20
   cmpb $40, (i)
   jb _sub40
   cmpb $60, (i)
   jb _sub60
   jmp _sub80

   //subtract 20, check negative, means i was between 0 and 19 (because 20 would produce a 0 not a negative flag)

_sub20:
   //cmpb $20, (i)
   //jnl _sub40 

   movl (b), %eax
   movl (c), %ebx
   movl (d), %ecx
   
   //(b and c) or ((not b) and d)

   //(b and c) has to be done before (not b) otherwise you are doing ((not b) and c)
   //store in c because c is not used in the other part
   andl %eax, %ebx

   //((not b) and c)
   notl %eax
   andl %ecx, %eax

   //combine 
   orl %eax, %ebx
   
   //upload
   mov %ebx, (f)
   movl $ii0x5a827999, (k)
   jmp common

   //subtract 40, means i was between 0 and 39 (but 0-19 was already filtered out)
_sub40:
   //cmpb $40, (i)
   //jnl _sub60
   movl (b), %eax
   movl (c), %ebx
   movl (d), %ecx
   xorl %ebx, %eax
   xorl %ecx, %eax
   movl %eax, (f)

   movl $0x6ed9eba1, (k)
   jmp common

   //subtract 60, etc
_sub60:
   //cmpb $60, (i)
   //jnl _sub80
   //(b and c) xor (b and d) xor (c and d)

   movl (b), %eax
   movl (c), %ebx
   movl (d), %ecx

   //(c and d)
   //this because all vars are used twice
   movl (c), %edx 
   andl %ecx, %edx

   //(b and c) store in c because thats not gonna be used
   andl %eax, %ebx

   //(b and d)
   andl %ecx, %eax

   //combine 
   orl %ebx, %edx
   orl %eax, %edx

   movl %edx, (f)
   movl $0x8f1bbcdc, (k)
   jmp common

   //subtract 80
_sub80:
   //cmpb $80, (i)
   //jnl _loopDone

   movl (b), %eax
   movl (c), %ebx
   movl (d), %ecx
   xor %ebx, %eax
   xor %ecx, %eax
   movl %eax, (f)
   
   movl $0xca62c1d6, (k)
   jmp common

common:

   //debug printf
   //mov $msg, %rdi 
   //mov (i), %rsi
   //call printf

   //mov i to reg so it's easier to handle
   xor %rbx, %rbx
   movb (i), %bl

   //temp = (a leftrotate 5) + f + e + k + w[i]
   movl (a), %eax
   movl %eax, %edx
   //leftshift does NOT leftshift so we need to add some bs
   shll $5, %eax    
   shrl $27, %edx
   orl %edx, %eax

   addl (f), %eax
   addl (e), %eax
   addl (k), %eax
   addl (%rsi, %rbx, 4), %eax

   //swap all the vars
   xor %rbx, %rbx
   movl (d), %ebx
   movl %ebx, (e)

   movl (c), %ebx
   movl %ebx, (d)

   movl (b), %ebx
   movl %ebx, %edx
//same thing here, shl does not leftshift
   shll $30, %ebx 
   shrl $2, %edx
   orl %edx, %ebx
   
   movl %ebx, (c)

   movl (a), %ebx
   movl %ebx, (b)

   movl %eax, (a)

   //debug printf
   /*mov $msg, %rdi 
   xor %rsi, %rsi
   xor %r8, %r8
   movb (i), %r8b
   mov %r8, %rsi
   call printf*/

   //increment i and check loop condition
   //incb %al
   //movb %al, (i)
   movb (i), %bl
   incb %bl
   movb %bl, (i)
   cmp $80, %bl
   //jne _loopDone this is clearly wrong you moron
   jl loop
   //jmp loop

_loopDone:

   /*movq (h0_addr), %rax 

   movl (a), %ebx
   addl %ebx, (%rax)

   movl (b), %ebx
   addl %ebx, 4(%rax)

   movl (c), %ebx
   addl %ebx, 8(%rax)

   movl (d), %ebx
   addl %ebx, 12(%rax) 

   movl (e), %ebx
   addl %ebx, 16(%rax)*/
   
   movl (a), %ebx
   addl %ebx, (%rdi)
   movl (b), %ebx
   addl %ebx, 4(%rdi)
   movl (c), %ebx
   addl %ebx, 8(%rdi)
   movl (d), %ebx
   addl %ebx, 12(%rdi)
   movl (e), %ebx
   addl %ebx, 16(%rdi)

   pop %rdx
   pop %rcx
   pop %rbx
   pop %rax
   //mov $yo, %rdi
   //call printf

   pop %rbp
	ret
