## caching part 2 electric boogaloe
- 8-way set-associative is most common(thats a power of 2)
- 2^x way associative needs an x-bit age counter for every block because you dont need to know how old they are, just that they are the oldest, so on cache hit just update every block younger than it with +1
- as alternative for least recently used replacement alg:
   - random etc 
     
## virtual memory
ch 6 12 8   
part of exam   
what happends when the adress points outside of installed mem? crashes without virtual memory   
devide mem into chunks (pages) and store some of them in memory, part on disk
you can swap pages to disk when not in use anymore
you can also map whole files to disk so that you don't need to load everything   
it's a hardware thing, everything uses virtual. the only exception before setting up virtual memory   
- demand paging: since pages are 4kb, bottom 12 bits are offset, rest is page index, page index is resolved and addded to offset which remains the same
   - one page table per process, special register in cpu (cr3?) that has the current page table address (one page table? one PML4 structure)
   - multiple pages can point to the same physical memory
   - page tables can be 2mb or 1 gb
   - address is split up, 12 lowest bits are offset, 9 bits per page table level index
   - every program gets all 4 levels, operating system keeps track
   - translation lookaside buffer?:
      - special cache for page tables
      
