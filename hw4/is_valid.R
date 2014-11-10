# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements: 

is_valid = function(g) 
{
    # Check that object is a list of lists.
   all( c(class(g), sapply(g, class)) == "list" )
    # Check if there are names for the primary list that they are all unique.
	length(g)==length(names(g))
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
	expect_false(c("FALSE") %in% as.character(
		lapply(g, function(x){
			x$weights > 0
	})))
	TRUE
}