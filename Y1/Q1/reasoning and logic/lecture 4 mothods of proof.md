### warm up
- penguins are black and white     
- some old tv shows are black and white     
- therefore, some penguins are old tv-shows


> $\forall{x}( penguin(x) \to (BnW()))$    
> $\exists{y}(tvShow(y) \land (BnW())$     
> $\therefore \exists{z} (penguin(z) \land tvShow(z))$

## excersizes
claim: every 4-digit palindromic number is divisible by 11
> $\forall{x}((4digit(x) \land palindromic) \to devides(11, x))$
- any 4 digit num is $a \cdot 1000 + b \cdot 100 + b \cdot 10 + a$
- $11 \cdot 92 \cdot a+10 \cdot b$
- k = 11*m
- since: num = 11*k, yes the conclusion is acurate

### part 2
claim: for all integers n>1: enevry n-digit palindromic number is divisible by 11

### part 3
claim: for all positive integers n, if 6 divides n then 3 also divides n    
$\forall{x}(div(3, x) \to div(6, x)$    
x = 6 * m   
x = 3 * 2m   

### part 4
claim: for all positive integers x, y, z, if y|x and z|y then z|x
$(y|x \land z|y) \to z|x$
x = y * m
y = z * n
x = z * n * m

### things to define
- predicates
- domain of discourse

> D = {a, b}  
> p = {a}
> BnW = {a, b}
> tv = {b}

### terms
- definition: assume it's true
- theorem: if you say it's true you have to prove it
- conjecture: a theorem we believe to be true but cannot prove


## proof types
- contradiction (show the oposite is wrong)
- generalization (use a arbitrairy element A which represents the domain)
- case (break down into smaller cases)
- contraposition ($a \to b$ gets turned into $\neg B \to \neg A$)

