check lecture 6 prep, prove gausses theorem, then use it.

### excersize
to prove 
> $\forall \space n n \geq 1 \displaystyle\sum_{i=1}^n 2i+1 = n^2$  

note that the original expression was $\displaystyle\sum_{i=1}^n A_i$ wher $A_i$ represents the i'th odd number (1->1, 2->3, 3->5)

base case:
> $\displaystyle\sum_{i=1}^1 2i+1 = 1^2$ wait what

inductive step:
> prove $\displaystyle\sum_{i=1}^k 2i+1 = k^2 \to \displaystyle\sum_{i=1}^{k+1} 2i+1 = (k+1)^2$   
> $\displaystyle\sum_{i=1}^{k+1} 2i+1 = \displaystyle\sum_{i=1}^{k} 2i+1 + 2i+1 = k^2 + 2i+1$   
> $k^2+2i+1 = (k+1)^2$

## invarates
### proof by invariant
* type of proof by induction
> invariant is a statement that is true after an iteration if it is true before the iteration
1. initialize base case, the invariant holds before first iteration 
2. prove if it holds before it also does after 
3. prove the loop ends
4. combine invariant and negation of guard to prove statement we are actually trying to prove

```
A(x, y)
a = x
b = 0
while(a >= 0):
   b = b + y
   a = a - 1
``` 
invariant:  b+a*y = x*y
first part is what we are actually doing, the second what we are trying to prove

### excersize 
clearly drink C
  
_  | A   | B  | C   | total
---|-----|----|-----|----
AA | -2  | 0  | 0   | -2
AB | -1  | 0  | 0   | -1
AC | -1  | 0  | 0   | -1
BB | 0   |-2  | 0   | -2
BC | 0   | -1 | 0   | -1
CC | 0   | 0  | -2  | -2

invariant: C is odd   
because C always goes down by 2 it MUST remain odd
1. C = 19, 2 does not devide 19 
2. C_new = C_old (still odd) || C_now = C_old - 2 (still odd)
3. Vi stops when there is 1 drink left, since the amount of drinks always go down for each case. therefore the loop must end
4. contradiction: assume C is not the last drink, since in 3 we have 1 drink left, which we assume is not a C. then C must be 0, 0 is even but our proven invarate states C can't be even. there fore the assumption must be false so it's converse must be true: C is the last drink
