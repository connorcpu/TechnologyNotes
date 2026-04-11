<<<<<<< Updated upstream
# to do - limits
=======
# to do
# - limits
>>>>>>> Stashed changes
   - l'hospital (LIMITS ONLY, NOT SERIES)
- derivatives
   - linearization
   - extreme values
   - implicit differentiation
   - newtons method
   - 3D derivation
      - partial derivation 
      - planerisation 
      - 'the chain rule' (?) 
      - directional derivative
- integration
   - substitution rule (reverse chain)
   - integration by parts (reverse product rule)
   - impropper integrals
   - 3D integration
      - over rectangle
      - over general region
- series
   - alternating series 
   - tests
      - comparison test 
      - integral test 
      - alternating test
      - ratio test 
      - p-series??
   - power series 
      - functions as power series 
      - taylor series 
         - taylor polynomials
- complex numbers
   - eulers identity

# stuff to memorize
- derivatives of inverse trigonometric functions
- $a^2 - b^2 = (a-b)(a+b)$
- $\displaystyle\lim_{n\to\infty}(1+{1 \over n} )^n = e$
- geometric series: $\displaystyle\sum_{n=0}^\infty (k)^n = {firstTerm \over 1 - k}$ -> convergent for k < 1, divergent for k $\geq$ 1
- mclauren:$\displaystyle\sum_{n=0}^\infty {x^n \over n!} = e^x$
- $\sin(x) = \displaystyle\sum_{n=0}^\infty {(-1)^n x^{2n+1} \over (2n+1)!}$
- $\cos(x) = \displaystyle\sum_{n=0}^\infty {(-1)^n x^{2n} \over (2n)!}$
- $\arctan(x) = \displaystyle\sum_{n=0}^\infty {(-1)^n x^{2n+1} \over 2n+1}$
- $\ln(1+x) = \displaystyle\sum_{n=0}^\infty {(-1)^n x^{n+1} \over n+1}$

- p-series: $\displaystyle\sum_{n=0}^\infty 1/n^p$ convergent for p > 1, dirvergent for p $\leq$ 1

# toolkits 
- limits
   - factoring
   - dividing by largest factor
- series
   - tests
      - comparison (solve that shi)
         - $\sum (k)^n = {firstTerm \over 1 - k}$
         - $\sum {x^n \over n!} / e^x$
      - integral (conv vs div)
      - ratio (conv vs div)
      - alternating (solve that shi using absolute convergence) (might just be sequences)
      - divergence test (only tell if it diverges by $\lim_{n\to\infty} a_n = 0$)
- derivatives
    $$\begin{align}ax^n & \to anx^{n-1} \\
    \frac 1 x & \to - \frac 1 {x^2} \\
    \sin(x) & \to \cos(x) \\
    \cos(x) & \to -\sin(x) \\
    \tan(x) & \to {1\over \cos^2(x)}\\
    \arcsin(x) & \to {1 \over \sqrt{1-x^2}} \\
    \arccos(x) & \to {-1 \over \sqrt{1-x^2}}\\
    \arctan(x) & \to {1 \over 1 + x^2}\\
    \ln(x) & \to \frac 1 x\\
    e^y & \to y'e^y\\
    p^x & \to \ln(p) \cdot p^x\\
    f(g(x)) & \to g'(x) \cdot f'(g(x))
    \end{align}$$
- anti-derivatives
   $$\begin{align} ax^n & \to \frac a {n+1}x^{n+1}\\
   \frac 1 x & \to \ln(x)\\
   \tan(x) & \to -\ln(cos(x)) \\
   \ln(x) & \to xln(x) - x \\
   p^x & \to \frac 1 {\ln(p)} \cdot p^x\\
   f(g(x)) \cdot g'(x) & \to f(u) \\
   \int f(x)\cdot g'(x) dx & \to f(x)g(x) - \int f'(x)g(x)dx
   
   
   \end{align}
   
# todo
- error bound
   - taylor's theorem & taylor's inequality
- newton-raphson
- limit comparison? may not be relavant
- [X] double integral (rectangle and weird areas)
- critcal points in 3d derivatives 
   - also look at gradient vectors
