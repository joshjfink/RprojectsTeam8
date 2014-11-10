# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements: 

is_valid = function(g) 
{
# Check that object is a list of lists.
	all(c(class(g), sapply(g, class)) == "list")
	length(g)==length(names(g))
	f <- sapply(g, function(x){
	  ifelse(is.na(x$edges), FALSE,
	  	ifelse(is.na(x$weights), FALSE,
	  	ifelse(length(x$edges)!= length(x$weights), FALSE,
	  		ifelse(x$weights < 1, FALSE,
	  		ifelse(class(x$edges)=="integer", TRUE, FALSE)))))
	})
	# Check that there are not any edges to non-existent vertices.
	# Check that each secondary list contains only edges and weights vectors that are of the appropriate type.
		h <- sapply(g, function(x){
		ifelse(duplicated(x$edges), FALSE, TRUE)
	})
	e <- NULL
	l <- length(g)
	e <- sapply(g, function(x){
	  all(max(x$edges) <= l)
	})
	ifelse(length(g[[1]])< 2,  FALSE,
			ifelse(all(length(unique(names(g))) != length(names(g))), FALSE,
		ifelse(names(g[[1]])== c("edges", "weights"), all(e, f, h), 
			ifelse(names(g[[1]])== c("weights", "edges"), all(e, f, h), FALSE))))
}
