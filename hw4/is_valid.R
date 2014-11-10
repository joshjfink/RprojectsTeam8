# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements: 

is_valid = function(g) 
{
# Check that object is a list of lists.
all(c(class(g), sapply(g, class)) == "list")
length(g)==length(names(g))
	# Check that there are not any edges to non-existent vertices.
	lapply(g, function(x){
	  expect_equal(length(x$edges), length(x$weights))
	})
	expect_error(expect_match(t, "TRUE"))
	# Check that each secondary list contains only edges and weights vectors that are of the appropriate type.
	for(i in 1:length(g)){
	n <- names(g[[i]])== c("edges", "weights") | names(g[[i]])== c("weights", "edges")}
	expect_match(n, "TRUE")
	expect_error(expect_match(n, "FALSE"))
	TRUE
}
