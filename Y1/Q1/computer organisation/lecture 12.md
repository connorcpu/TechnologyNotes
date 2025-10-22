superscalar:
   - fetch and decode way ahead
   - split different opperations across different units, like a seperate floating point unit and integer unit etc
   - multiple busses because bottleneck, fuck how busses work, mess it up, seperate ALU busses and full bussses
   - also fetch a bunch of instructions at a time, like 16KiB at a time
   - finish instructions in program order
   - superscalar trickery:
      - speculative execution: just do random shit, see if it works
         - just execute both branch options for 100% accuracy
         - runahead to check for cache misses
      - register renaming:
         - when blindly writing to registers a register is renamed to remove some dependencies when reusing registers with different variables
      - hyerthreading: just run 2 logical cores, when one is waiting, run the other one

highest midterm: 3825
lowest score: 0
second lowest: 275

parallelization:
- $t = T_{orig} * (f_s + {f_p} \over p)$
   - p is amount of proccessors
   - t is time it takes 
   - t_orig is time it would take 
   - f_s is sequential part
   - f_p is parallelizable part
- instructions 
  - sisd
  - simd
  - mimd
  - misd

- shared memory between cores: UMA (deprecated), now w do numa (non-unifurm memory acccess architecture, or distrubuted memory
   - numa: div mem over cpu's, then cpu askes other cpu for data if it gets requestited
   - distrubuted: problem div'ed, system just pparses it
   - bus? overload!
- 
