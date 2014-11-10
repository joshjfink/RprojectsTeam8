# Input - g1, a graph object; g2, a graph object.
# Output - true if g1 and g2 are isomorphic, false if not.
# Description - Check if the graph objects are isomorphic, 

is_isomorphic = function(g1, g2)
{
   # Check all vertices are dientical. Comparison of vertices should be based on names not indexes--indexes should only be used if vertex labels are not defined.
		expect_identical(names(g1), names(g2))
	# Check all edges are dientical
		expect_identical(g1, g2)
	TRUE
}
