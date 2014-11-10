# Input - g1, a graph object; g2, a graph object.
# Output - true if g1 and g2 are isomorphic, false if not.
# Description - Check if the graph objects are isomorphic, 

is_isomorphic = function(g1, g2)
{
	# Match the edges in g2 based on their order in g1
for(i in 1:length(g1)){
	g2[[names(g1)[i]]]$edges <- g1[[names(g1)[i]]]$edges
}
# Match the edge/name order in g2 w/g1
g2 <- g2[names(g1)]
# Test for equivalence
all(g1 %in% g2)
}

