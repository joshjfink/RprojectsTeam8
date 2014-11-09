#### 
# Setup
####

###### Graph for Testing
	# # Test Graph
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

	# g <- graph2 

# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements -      

# Check that object is a list of lists.
	test_that("is_valid", {
		expect_true(is.list(g))
		lapply(g, function(x){
			expect_true(is.list(x))
		})
	})

# Check if there are names for the primary list that they are all unique.
	expect_equal(length(g), length(names(g)))
	expect_error(expect_match(t, "TRUE"))

# Check that each secondary list contains only edges and weights vectors that are of the appropriate type.
	lapply(g, function(x){
	  expect_identical(names(x), c("edges", "weights"))
	})

# Check that there are not any edges to non-existent vertices.
	lapply(g, function(x){
	  expect_equal(length(x$edges), length(x$weights))
	})

# Check that all weights are not less than or equal to 0.
	if(c("FALSE") %in% as.character(
		lapply(g, function(x){
			x$weights > 0

	}))) stop("No, only positive weights allowed")
