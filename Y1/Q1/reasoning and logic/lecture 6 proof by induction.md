## proof by induction
consider the one place predicate P.
if we can prove $p(0)$ and $p(0) \to p(1)$. By induction we have now proven p(1).
Now presume we can prove for any N $p(n) \to p(n+1)$, proving any N will cause a chain reaction proving 
all N's greater than the proven base-case.  
Written formally this mean if we can prove $p(0) \land \forall{k} \space p(k)\to p(k+1)$ we can safely conclude $\forall n \space p(n)$


try and prove:
> $\forall{n} \in \mathbb{Z} , n \geq 1: \displaystyle\sum_{i=1}^n i \cdot 2^i = (n-1) \cdot 2^{n+1}+2$ 

- proof by induction on N
- let p(n) denote $\displaystyle\sum_{i=1}^n i2^i=(n-1)2^{n+1}+2$ $D = \mathbb{Z}$
- base case: to prove: P(1)
- $\displaystyle\sum_{i = 1}^1 i2^1 = 1 \cdot 2^1 = 2$
- $(1-1) \cdot 2^{1 + 1} + 2 = 2$
- induction step: to prove: $\forall n \in \mathbb{Z} \space p(n) \to p(n+1)$
- assume p(k) [is true], that is $\displaystyle\sum_{i=1}^k i2^i = (k-1)2^{k+1}+2$
- to prove: p(k+1)
- $\displaystyle\sum_{i=1}^{k+1} i2^i = \displaystyle\sum_{i=1}^k i2^i + (k+1)2^{k+1}$ (where the fuck does this come from)
- $= (k-1)2^{k+1} + 2 + (k+1)2^{k+1}$
- $= (k-1 + k + 1)2^{k+1} + 2$
- $= k \cdot 2 \cdot 2^{k+1} + 2$
- $= k \cdot 2^{k + 2} + 2$ (how is this proven)
- therefore p(k+1) is true so, $p(k) \to p(k+1)$
