# NOT FORMATIVE
# DO NOT FAIL MIDTERMS IF YOU WANT A CHRISTMASBREAK


assembly:
   - param register order is rdi>rsi>rdx>rcx>r8>r9
   - returns in rax
   - 15 bytes is max instruction length which includes opcode and operands (8 bytes per mem address)

## Karnaugh maps:
   - only change one variable when moving to the next column
   - group 1's:
      - only vertical or horizontal
      - across boundaries (wrap left-right and top-bottom)
      - only groups sizes that are a power of 2
      - in as large as possible groups
      - in such a way all 1's are covered
      - overlapping groups to make larger areas is allowed
      - groups should always be reqtangular? 
      - dont-care values can be set to 0 or 1, use 1 when it can enlarge a group
   - enter constants into formula per group (x_1 is the same for each 1 in a group, enter not x_1 if it's always 0, or x_1 if it's always 1)

### architeture
- von neuman means varables and data in the same address space and 'organs' attached to a bus to the CPU
- cisc/risc 
- flip/flops are 1 bit registers
- single bus
- dual bus 
- north, south-bridge
- 'modern' (move north and part of south into CPU)
- bus carries 3 sets (types?) of lines:
   - control (how to interpet: read, write, clock interrupt)
   - address line (what location we want, can be used to write to memory mapped devices)
   - data line (just carries the actual data)
- addressing types:
   - immediate: value (mov $25, %rax)
   - direct: m(val/loc) (location: .byte 42; mov location, %rbx (dereference pointer))
   - register: [reg] (mov %rax, %rbx)
   - indirect register: m([reg]) (mov (%rbx), %rax)
- port mapping: [TODO: find out what exactly you are mapping]
   - cons: you need special instructions and ways of addressing
   - depricated
- memory-mapped: map memory addresses to device registers
   - cons: wastes memory addresses 
   - modern way of doing it
- bus synchronisity: make sure to have a 'slave-ready' line because due to delay the data will never arive on a clock cyle and could spil over into next clock cyle, also you don't know if there is no data or if the data is 0 without seperate line

data rep:
   - S&M (sign and magnitude)
   - 1's compliment
   - 2's compliment 
   - excess-2: when stored in excess you have too much, remove the excess to have to go back to normal: 7 in excess-2 has 2 to much so it's 5
      - excess is always unsigned
   - IEEE-754
      - [TODO: learn floating point multiplication]
      - [TODO: look at floating point addition, should not be too hard, multiplication should be super simple]
      - to subtract, flip second mantisa, sign bit become whatever bigger exponent had [TODO verify this]

## notes
- NOT FORMATIVE 
- IF YOU WANT CHRISTMASBREAK DONT FUCK UP MIDTERMS
- 32 bit word means double word, 64 bit word means quad word

todo:
   - FILE IS UNFINISHED
   - check old exams
   - finish file 
   - check book 
   - check self study
   - check the slides
   - learn logic circuit icons
