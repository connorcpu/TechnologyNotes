## set theory II

- $ |A| $ means size of A
- $|\mathbb{N}| \neq \infin$
- $a \subset x$ (a subset b) a is a propper subset of b which means a and b cannot be equal, also sometimes noted as $A \subsetneq B$ for the sake of clarity
- $a \subseteq b$ (a subseteq b) a is an **in**propper subset of b which means a and b **can** be equal
- $\supset$ means super set, basically just subset but the otherway around, $A \subset B \equiv B \supset A$
- $\wp{A}$ is a set with all subssets of A, including the empty set and A itself, $|\wp A| \ 2^{|A|}$

### first question
how can we show for sets A and B that $A \neq B$ holds
- if size is different they can't be the same, only works for finite sizes
- $\exists x \space ((x \in A \land x \notin B) \lor (x \notin A \land x \in b))$
- $a \subset b \lor b \subset a$

### second question 
prove there exists only one $\emptyset$
- proof by contradiction 
   - assume there is not 'only one $\emptyset$
   - case 1: there is no $\emptyset$ (condradiction: {})
   - case 2: there are more than 1 $\emptyset$
      - >$\exists \psi, \emptyset \space \psi = \{\} \land \emptyset = \{\} \land \psi \neq \emptyset$
      - >$\forall x(x\in \psi \to x \in \emptyset$ means $\psi = \emptyset$ (vacous truth)
      - >$\forall x (x\in \emptyset \to x \in \psi)$

### third question 
prove that for all sets A and B: $A \subseteq B \iff \wp{A} \subseteq \wp{B}$
- take arbitrairy
- prove implication and the otherway arround
- assume $e \subseteq f$, prove $\wp e \subseteq \wp f$
   - $\forall x (x \in \wp e \to x \in \wp f)$
   - take arbitrairy k such that k is emelemnt in $\wp e$, now prove it's also in $\wp f$
   - $k\in \wp e$ means $k \subseteq e$ by transitivity (?) $k \subseteq f$ which means $k \in \wp f$
   - therefore we proven the if, now for the otherway around
   - assume $\wp e \subseteq \wp f$
   - to prove: $e \subseteq f \equiv \forall x(x \in e \to x \in f)$ 
   - take arbitrairy k such that $k \in e$
   - to prove: $k \in f$
   - $k \in e$ means $\{k\} \subseteq e$ means $\{k\} \in \wp e$ means $\{k\} \in \wp f$ means $\{k\} \subseteq f$ means $k \in f$
   - random notes: $1 \in \mathbb N$, therefore $\{1\} \subseteq \mathbb N$


# carteasion products
- () is not the same as {}, with {} the order does not matter ({a,b} = {b,a}), but () means ordered
- $A \times B = \{(a, b) | a \in A \land b \in B\}$ (definition)
   - this means, the set of all ordered pairs where the first of the pair comes from the first set and the second from the second set.
   - example: A = {1,2}, B = {4,5,6}
   - then: $A \times B$ = {{1,4),(1,5),(1,6),(2,4),(2,5),(2,6)}.
   - $A \times B \neq B \times A$ because the cartesian product is a set of **ordered** pairs
- $(a,1) \in A \times B$
- $(1,a) \in B \times A$
- $|A \times B| = |A| \cdot |B|$
- $|A \times \emptyset| = 0$
- $A \times \emptyset = \emptyset$


## uhm
$A \times B \times C$ might equal $(A \times B) \times C$, usually it does not mean that in the book

# structural induction
1. $0 \in \mathbb N$
2. $x \in \mathbb N \to x + 1 \in \mathbb N$
3. nothing else is in there 
   
   
given a set of strings A for the alphabet {m,i,a}
1. $m \in A$
2. $x \in A \to xi\in A$
3. $x\in A \to mxa \in A$
4. nothing else is in A other than what i put in it
