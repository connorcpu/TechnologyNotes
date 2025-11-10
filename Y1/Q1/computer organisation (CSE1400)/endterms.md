2023-2024 endterm: # we might be in trouble - MAR is memory address register MDR is memory data register when control circuit says, R_1_out, MAR_in address goes from R1 to MAR, control circuit then goes READ and then WMFC this also goes for PC (program counter) out because that generates the next address to fetch instructions always run PC_out to MAR_IN, read, WMFC. then MDR out IR in. that insures the next instruction? idk control circuit has a lookup tabel to translate instructions to micro instructions for unconditional branches you can chop off writeback phase using hardware leading to a 1 cycle reduction
- since branches are basically guarenteed to stall you can execute the jmp and then the instruction before it so
that instruction goes in the stalled slot
- backwards branch is a loop usually so usually taken
- forewards branches are exceptions or smt and usually skipped
- 


## 2024-2023 endterms
1. - a: because input can't be choose one, must be one of the 2
   - b: - PC_out, MAR_in, READ, WMFC 
        - MAD_out, IR_in
        - RF_addr=RAX, RF_out, x_in
        - z_in, mult_x, ROT13
        - z_out, RF_addr=RAX, RF, in
2. - a: ceil(log2(20))
   - b: [TODO] figure out what interleaved vs flat layout is
3. this i can do 
4. - a: 160ms/s reserved for normal guitar, (8+37)*14 for winged so 630 in subtotal, 790 total. 790<1000 so we are good FORWARDING GRANT IS WHAT ADDS TIME TO DAISY CHAINING
   - b: 40 per note for normals, 45 for winged, 85 total, 10 notes/s will get you 850, 11 935, 12 will be insufficient, but 1000/85 is the correct awnser
5. - a: pcgenerator, takes no input from the bus, X_in, Z_out.  
   - b: it takes much less bits to encode which register you mean vertically rather than horizontall6. - a: que?? a=1?? AxB MEMORY ORGINISATION MEANS B DATA PINS AND A ADDRESS PINS
6. - a: que?? a=1?? AxB MEMORY ORGINISATION MEANS A LOCATIONS, EACH HOLDING B BITS
   - c: depends on the word size ig, usually byte addressable so would be 1/8th, but words were 8 bytes a sec ago so 1KiB?
7. - LRU means #10, #1, #2, #9 get cached, #15 is first cache miss, #10 gets tossed, #1 is a hit, #16 is second miss, that tosses #1, and 9 is a hit, so 6 misses total 
     LFU means #10, #1, #2, #9 get cached, #15 is first cache miss, #2  gets tossed, #1 is a hit, #16 is second miss which tosses #9, #9 is a miss so 7 misses
     so LRU.
   - Most people listen to an album in order so every song has the same frequency therefore LRU, other way of thinking is if you heard a song you dont wanna listen again for quite a while so also LRU
8. - a: advantage is more acurate trashing algorithems and no wasted space in cache, disadvantage is it's slower to hit
   - b: depends what contention means but we have hybrid, and more efficient than direct does not exist because you know with 1 check if it's in the cache. HYBRID IS CALLED SET-ASSOCIATIVE
9. WHEN TALKING PAGE TABLES THEY ONLY CONSIDER 1 LAYER BUT 16KB PAGES  I THINK
