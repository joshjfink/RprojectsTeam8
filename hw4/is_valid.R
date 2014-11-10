# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements: 

is_valid = function(g) 
{
# Check that object is a list of lists.
	all(c(class(g), sapply(g, class)) == "list")
	length(g)==length(names(g))
	# Check that there are not any edges to non-existent vertices.
	# Check that each secondary list contains only edges and weights vectors that are of the appropriate type.
	e <- NULL
	e <- sapply(g, function(x){
	  all(max(x$edges) <= length(x))
	})
	ifelse(length(g[[1]])< 2,  FALSE,
		ifelse(all(length(bad_g1[[1:length(bad_g1)]]$edges)!= length(bad_g1[[1:length(bad_g1)]]$weights)), FALSE,
		ifelse(names(g[[1]])== c("edges", "weights"), all(e), 
			ifelse(names(g[[1]])== c("weights", "edges"), all(e), FALSE))))
	
}
