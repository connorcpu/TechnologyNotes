- derivatives 
- integrals
- limits
- newtons method
- series
   - taylor series
   - convergence
- 3D
   - planerization
   - multi-var integration


# tests

test               | tests for                         | feature
-------------------|-----------------------------------|-----------
divergence test    | divergence                        | simple
geometric series   | full info                         | known sum
integral test      | absolute convergence & divergence | gives error bound
p-series           | full info                         | useful comparison
alternating series | convergence                       | gives error bound
comparison         | absolute convergence & divergence | widely applicable & gives error bound
ratio              | absolute convergence & divergence | power series

## alternating series test 
- $|b_{n+1}| \leq |b_n|$  (the next value must always be closer to 0 then the last)
- $\displaystyle\lim_{n\to\infty} |b_n| = 0 (the limit must equal 0)

## comparison test
if $b_n$ converges and $\forall n a_n \leq b_n$ then $a_n$ is also convergent.   
if $b_n$ diverges and $\forall n a_n \geq b_n$ then a_n is also divergent   
this means that if $\displaystyle\lim_{n\to\infty} \frac {a_n} {b_n} > 0$ both series do the same

## absolute convergence
if the absolute value of a series ($\sum |a_n|$) is convergent, then so is the series itself via absolute convergence   
this does not mean that any convergent series is also absolutely convergent, if this is the case it's conditionally convergent

## ratio test 

- $\displaystyle\lim_{n\to\infty} {|a_{n+1}| \over |a_n|} = L$
- L < 1 convergent
- L > 1 or L = inf divergent
- L = 1 inconclusive


# to remember
- $\frac 1 {a-b(x)} = \displaystyle\sum_{n=0}^\infty (\frac {b(x)} a)^n$
- $\ln(1+x) = \displaystyle\sum_{n=0}^\infty {(-1)^n \over 2n + 1} x^{2n+1}$
- $\arctan(x) = \displaystyle\sum_{n = 0}^\infty {(-1)^n \over 2n+1} x^{2n+1}$
- $e^x = \displaystyle\sum_{n=0}^\infty \frac {x^n} {n!}$
- $\cos(x) = \displaystyle\sum_{n=0}^\infty {(-1)^n x^{2n} \over 2n!}

- higher order derivative $f^{(k)}(x) =$ power series at index k multiplied by k!
   

