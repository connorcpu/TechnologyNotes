# orginisation
- all dutchies ofc
- lecturer..... nickolaas verhulst, een belg, wtf is bruusk
- head teacher is niek de kleijn
- calc 1, niet calc....
- week 2.5 short answer test 1
- week 2.10 open question test 2
- week 10 weegt 2x, gem moet boven 5.75 en test 2 5.0 of hoger
- pre-lecture vid, expected to watch and understand
- grasple for practice

# cursus stuff
## functies

- niet injectiefe functies hebben soms geen inverse
- function is a $\forall \alpha \in A \exist !b \in B: (a, b) \in R$ (for every input exactly 1 output)
   - $\exists !b$ means exactly 1 
- $R \subseteq a \times B$
- function name: $f: a \to b$
   - f is function name 
   - a is input (domein)(type output geen set)
   - b is output (domein)(geen set)
   - bereik/range is set van alle outputs 
   - set van alle inputs?
- functie is set van tuples (koppels)
- per definitie van een functie hebben verticale lijnen 1 snijpunt
- within CSE1200, functions are implicitly $\subseteq \R \to \R$
- no domain means maximum subset of $\R$
- inverse notatie is $f ^{-1}(x) = g(x)$
   - definitie: $(f \circ f^{-1})(x) = x$
- functie is inverteerbaar als hij one-to-one is (injectief)
- functie $f^{-1^{-1}}$ waar $f(x) = x^2$ does not mean $f^{-1^{-1}} = f$


### compositie
$f: A \to B$  
$g: B \to C$  
$h: A \to C = g(f(x))$   
$h = (f \circ g)(x)$   
$f \circ g$ almost never equals $g \circ f$

## inverse functies
- maakt functies 'ongedaan' meestal niet maar soms wel

- als g inverse is van f: $f(x) = y \to x = g(y)$

## inverse trigo functies
sinus spiegelen werkt natuurlijk niet, output is geen functie, dus geen inverse van sinus, valt alleen te does als je sinus domein beperkt.
Als je dus domain beperkt, dan word dan een beperkt codomein voor de inverse. inverse van sinus met beperking heet sinusboog  
$sin^{-1} = arcsin$   
- same goes for cos but interval is 0 to pi because otherwise not that curve we want

## limieten
- waneer linker en rechter limiet zelfde zijn dan is er geen limiet 
- functie is contiue als $\displaystyle \lim_{x \to a^+}f(x) = f(a)$

## examples
### 1
$f: \R \to \R, x \to x^2$   
$1/x$ is niet goed gedefinieerd want heeft niks op x=0 dus moeten we de functie beter definieren zodat het domein een subset is van $\R  \setminus \{0\}$ 
### 2
inverse van $f: \R \to \R, x \mapsto { {3x+1} \over 2}$ is $g(y) = {{2y-1} \over 3}$
### 3 
inverse van $f: \R \to \R, x \mapsto 3x+5$ | $f^{-1} = 1/3 (x-5)$
### 4
inverse van $f: \R \to \R, x \mapsto x^2$ | $f^{-1} = \emptyset$
this is because for one of the outputs you cannot tell weather it's the positive or negative input value.
not the sqrt because that's always positive and input could have been negative
### 5 
inverse van $f: \R \to \R, \sqrt x$ with domain $[0, \infin) and codomain $\R$ is $f^{-1}: x \mapsto x^2$
want bereik van inverse moet domain van origineel worden, dus domain van infverse in $\R$ and codomain is $[0, \infin)$

