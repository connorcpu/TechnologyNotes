1. check previous end terms
2. read through all the slides
3. read through all the notes
4. try making old exam


25th was christmas
26th more christmas 
27th work
28th more work 
29th TIME
30th lorette met roos
31th naar roos haar oma
1th  TIME 
2th  TIME 
3th  work 
4th  more work 
5th  lectures/time 
6th  RESIT

1. irq raised over hardware interface
2. CPU stops program execution
3. interrupts are disabled
4. device is informed of acceptance and clears IRQ 
5. ISR is invoked to handle interrupt 
6. enable interrupts
7. resume execution

- immediate: movq $6, %rax
- direct:    movq [label], %rax
- register:  mov %rax, %rax
- register indirect: mov [%rax], %rax

- $t_p = t_s \times (f_s + \frac {f_p}{p})$

- sisd: just regular instructions
- simd: apply instruction to every element in array (this is GPU)
- mimd: 
   - NUMA: each core gets it's own memory and other cores can access others memory just slower
   - DMA: each core gets it's own memory other cores have to request memory through other cores with a request

# feedback

1. (blank) look at MISD/SISD
2. (wrong)
   - read the question/speedup in percentage/when pipelining, check original time :smh:
   - dunno
3. (right-ish)
   - check contention and collision
4. (right-ish)
   - no clue what happend here, check BPU model and microcode
5. (wrong)
   - learn powers of 2
   - answer all questions, what is different?? how does the new address look????
6. (wrong) dunno
7. (completely correct) relearn the bloody formula!!
8. memory arrays: 16x16, 32x8, 256x1?? row pins column pins data pins; i dont get any of it
9. WHAT WERE YOU SMOKING, reducing something from 12 cycles to 2 is A 6X SPEEDUP YOU DUNCE
10. when they say they want to "memory map" a space and ask how many bits we need for virtual addresses THEY ONLY WANT HOW MANY BITS THEY WOULD NEED TO INDEX ALL THE PAGES
11. (blank) learn SRAM vs DRAM


things to practice:
1. karnaugh maps
2. i/o (daisy chaining)
3. memory chip select
4. (s/m)i(s/m)d 
5. acces types (immediate/direct/register/inderect register)
6. SRAM electronic wiring
7. von neuman
8. look at BPU again
9. parallel fromula ($t_p = t_s \times (f_s + \frac {f_p}{p}$)
10. look at mantissa formule and fixed point binairy fractions ($(-1)^s \times 2^{e-127} \times m$)
   - where s is sign bit
   - e is exponent in excess 127
   - m is mantissa with implicit 1. prepended, highest bit is $2^{-1}$, second is $2^{-2}$
11. learn how to operate on 2's compliment
12. 
