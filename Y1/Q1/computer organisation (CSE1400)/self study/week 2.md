1. george bool
2. bla
   - a: ~((AB) OR ~(C + ~C)) OR ((C + ~C) AND ~(D AND D))
   - b: 
     
ab/cd | 00 | 01 | 11 | 10
------|----|----|----|---
00    | 1  | 1  | 1  | 1
01    | 1  | 1  | 1  | 1
11    | 1  | 0  | 0  | 1
10    | 1  | 1  | 1  | 1

   - c: D or (Not A and B) (logic)

   - c: (not A) or (not D) or (not B) (karnaug)
   - E: yes using NOR, and (or even {or+not})
3.

cd/ab | 00 | 01 | 11 | 10
------|----|----|----|----
00    | 1  | 1  | 1  | 0
01    | 0  | 1  | 1  | 0
11    | 1  | 1  | 0  | 1
10    | 1  | 0  | 0  | 0

NOT A * NOT B * NOT D = {(0, 0, 0, 0), (0, 0, 1, 0)}
B AND ~C = {(0, 1, 0, 0), (1, 1, 0, 0), (1, 1, 0, 1), (0, 1, 0, 1)}
NOT B * C * D = {(0, 0, 1, 1), (1, 0, 1, 1)}

4. 
