## more set theory

## trees and graphs
- vertex: node
- edge: line between nodes
- undirected: no arrows (noted with braces {})
   - 2 directed arrows from a to b and from b to a could be substituted with 1 undirected edge depending on the use case
- unweighted: no weights on edges (noted with paranthesis ())
- vertices have a degree, how many edges it has
   - outdegree is how many leave (directed edge)
   - indegree is how many enter (directed edge)
- edges are treated as part of a set in this course, this means edges are unique; multisets are where theres a collection of edges, meaning multiple paths
- in this course we consider simple graphs which don't allow self-loops
- in a **simple** path vertices are not reused
- dag: directed a-cylclic graph (always eventually reaches 1 node)
- topological ordering: ordered list of vertices, all nodes with a out edge it must come before the corrisponding invertex
   1. pick vertex without incoming edges 
   2. add that vertex to ordering 
   3. remove that vertex and it's edges 
   4. repeat till graph gone
- trees are (value, (child1, child2, ...))

## random things
### 1
3+2+7=12

### 2
find out what $v \in \{v \in V | (B, v) \in E\}$ notation means
sum of the degrees over all the vertices in a set,

### 3
draw (8, ((4, emp),(2,(emp,(12,(emp,(2,emp)))))))

### 4
prove that for full binary trees the num of internal nodes is exactly 1 less than the number of leaf nodes
$\forall t \in FBTREE (f_i(t) = f_l(t)-1)$   
case add internal node, must give +2 on leafs; case add leaf node???
solution:
- base case: 
to prove: $\forall x (f_i((x, \empty)) = f_l((x, \empty))-1)$, pick arbitrairy k for x    
one leaf node, tada 0 = 1 - 1
- inductive step:
$\forall t_1,t_2 (t_1,t_2 \in FBTREE \to f_i(t_1,t_2) = f_l((x, (t_1, t_2))) - 1)$   
another arbitrary $s_1$ and $s_2$ such that our claim holds for $s_1$ and $s_2$   
to prove: $f_i((b, (s_1, s_2)) = f_l((x, (s_1, s_2)))$

## general things 
- mod 1: propositianal
- mod 2: first-order
- mod 3: constructing proofs
- mod 4: induction
- mod 5: set theory 
- mod 6: functions and relations

#
