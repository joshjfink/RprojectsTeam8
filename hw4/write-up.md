## Team 8: HW 4
### A Brief Guide to Our Graph Functions

 Yanyu Liu, Joshua Fink , & Zheng Ding

### PREDICATES
***

**is\_valid.R**
_(still in 'beta')_

**is\_undirected.R**
 The idea of this function is test whether the graph object is directed--i.e., favorably weighted a vertex or set of verticies--of if the graph object is undirected or balanced. Here, we loop over the weights on the edges to determine whether the flow of the graph leads more heavily toward a given vertex.

**is\_isomorphic.R**
 Creating the isomorphic function was a deceptively irksome task. The first version of it was well over 50 lines of code attempting to bob and weave through specific restrictions we deemed testable. As the work progressed, brevity in syntax and accuracy in performance showed a strong assoicaiton, and the version of the function we present here is only a few line of code.
 We use a for loop to match the edges in graph2 to the names for the edges in graph 1, we then resort the graphs and use the %in% operator to test for equivalence

**is\_isconnected.R**
_(still in 'beta')__

### INPUT/OUTPUT
***

**write\_graph.R**
_(description here)_

**read\_graph.R**
_(description here)_

### SHORTEST PATH
***

**shortest\_path.R**
 We use the idea of recursive. The function path\_len is used to calculate the length of a path; short_path is the main recursive function.

### MINIMUM SPANNING TREE
***

**min\_span\_tree.R**
 According to the Prim Algorithm, we use get_adj_mat2 function to get the adjacent matrix (use Inf rather than 0 as default value of the matrix);  then we use add_vertex function to add vertex for minimum span tree. In the main function, U is used to store the vertexs which has been included in the function; V is the vertexs which is not included in the function. adjvex represents the minimal-weight edges between each vertex to U; lowcost stores the weight of these edges. Each time a vertex will be included into U, then adjvex and lowcost will be updated.

