# NOT FORMATIVE
# DO NOT FAIL MIDTERMS IF YOU WANT A CHRISTMASBREAK


assembly:
   - param register order is rdi>rsi>rdx>rcx>r8>r9
   - returns in rax
   - 15 bytes is max instruction length which includes opcode and operands (8 bytes per mem address)

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
   - immediate
   - direct 
   - register 
   - indirect register [TODO: understand what the fuck he means here]
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
   - excess-2
   - IEEE-754

## notes
- NOT FORMATIVE 
- IF YOU WANT CHRISTMASBREAK DONT FUCK UP MIDTERMS
- 32 bit word means double word, 64 bit word means quad word
