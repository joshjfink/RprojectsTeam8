###### Graph for Testing
	# # Test Graph
	# graph1 = list(A = list(edges   = c(2L),
	#                        weights = c(14)),
	#               B = list(edges   = c(3L,4L),
	#                        weights = c(23,13)),
	#               D = list(edges   = c(1L),
	#                        weights = c(5) ),
	#               F = list(edges   = c(1L,5L),
	#                        weights = c(43,33)),
	#               N = list(edges   = c(1L,2L,4L),
	#                        weights = c(33,22,11)))

	# g1 <- graph1 
	# graph2 = list(A = list(edges   = c(2L),
	#                        weights = c(14)),
	#               B = list(edges   = c(3L,4L),
	#                        weights = c(23,13)),
	#               D = list(edges   = c(1L),
	#                        weights = c(5) ),
	#               F = list(edges   = c(1L,5L),
	#                        weights = c(43,33)),
	#               N = list(edges   = c(1L,2L,4L),
	#                        weights = c(33,22,11)))

	# g2 <- graph2 

# Function - is_isomorphic
# Input - g1, a graph object; g2, a graph object.
# Output - true if g1 and g2 are isomorphic, false if not.
# Description - Check if the graph objects are isomorphic, 

# Check all vertices are dientical. Comparison of vertices should be based on names not indexes--indexes should only be used if vertex labels are not defined.
expect_identical(names(g1), names(g2))
# Check all edges are dientical
expect_identical(g1, g2)