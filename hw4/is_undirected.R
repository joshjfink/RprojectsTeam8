#### 
# Setup
####

###### Graph for Testing
	# Test Graph
	graph2 = list(A = list(edges   = c(2L),
	                       weights = c(14)),
	              B = list(edges   = c(3L,4L),
	                       weights = c(23,13)),
	              D = list(edges   = c(1L),
	                       weights = c(5) ),
	              F = list(edges   = c(1L,5L),
	                       weights = c(43,33)),
	              N = list(edges   = c(1L,2L,4L),
	                       weights = c(33,22,11)))

	g <- graph2 


# Function - is_undirected

# Input - g, a graph object.
# Output - true if undirected, false if not.

# Description - Check if the graph object is undirected, this is true if all directed edges have a complementary directed edge with the same weight in the opposite direction.

is_undirected = function(g)
{
    TRUE
}

store <- rep(0, length(g))
for(i in 1:length(g)){
	store[i] <- sum(g[[i]]$weights)-
sum(unlist(
lapply(g, function(x){
	x$weights[x$edges==i]
})))
}
