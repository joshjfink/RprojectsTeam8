# Input - g1, a graph object; g2, a graph object.
# Output - true if g1 and g2 are isomorphic, false if not.
# Description - Check if the graph objects are isomorphic, 

is_isomorphic = function(g1, g2)
{
   # Check all vertices are dientical. Comparison of vertices should be based on names not indexes--indexes should only be used if vertex labels are not defined.
	# is_valid(g1)
	# is_valid(g2)

	g3 <- g2
for(i in 1:length(g1)){
	g3[[names(g1)[i]]]$edges <- g1[[names(g1)[i]]]$edges
}
g3 <- g3[names(g1)]
all(g1 %in% g3)

}

