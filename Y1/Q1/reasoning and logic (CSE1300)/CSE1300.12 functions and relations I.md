- $f: A \to B$ f is a function, feed it an element of set A and it produces exactly 1 output that is in the set B
- $B^A$ is the set of all functions that map A to B, so $f: A \to B$ means $f \in B^A$
- $f: A^2 \to B^2$ means an ordered pair, both elements of which are in A, map to an ordered pair made up of elements of B
   - this is useful for $f: \mathbb{N}^2 \to \mathbb{N}^2$ which means f maps some orderd pair of natural numbers to another ordered pair of numbers

## relationship properties
- the following are propperties relations can have or not have: $\mathcal{R}$ is said to be ... when, $\mathcal{R}$ is assumed to always be [applied] on the set we are talking about ig
   - reflexive means, all element in A have $\mathcal{R}$ with themselves, ($\forall a \in A (a \mathcal{R} a)$), 
      - for example, $\leq$ on $\N$ is true because any n is less than or equal to that same n
   - transitive means if $a \mathcal R b$ is true, and $b \mathcal R c$ than $a \mathcal R c$ is also true, assuming the relation is transitive. ($\forall a \in A,\forall b \in A,\forall c \in A ((a \mathcal R b \land b \mathcal R c) \to (a \mathcal R c))$)
      - for example, when working on a set of people, the relation between 2 elements 'is direct child of' is not transitive because a child of a child of a person is not their direct child
      - on the other hand the binary relation 'is decented of' is transitive because a decended of a decended is a decended of the original person
   - symmetric means that the relation is reversable: $\forall a \in A, \forall b \in B(a \mathcal R b \to b \mathcal R a)$
   - antisymmetric means for no element is the relation symetrical, execept maybe itself.
      - $\leq$ is antisymmetric on $\N$ because no a is less than or equal to b if b is less than or equal to a unless a equals b
   - partial ordering is if a relation is reflexive, transitive and antisymmetric
   - total ordering is when for any a and B from A either $a \mathcal R b \lor b \mathcal R a$ is true
