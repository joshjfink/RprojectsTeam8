# Input - g, a graph object.
# Output - true if undirected, false if not.
# Description - Check if directed edges have a complementary directed edge with the same weight in the opposite direction.

is_undirected = function(g)
{
    # Generate matrix
		n = length(g)
		m = matrix(0, ncol=n, nrow=n)
		for(i in 1:n){
			m[i, g[[i]]$edges] = ifelse(FALSE, g[[i]]$weights/sum(g[[i]]$weights), g[[i]]$weights)
		}
	# Check if directed edges have a complementary directed edge with the same weight in the opposite direction.
		m.direct <- which(abs(m-t(m))!=0,arr.ind = T)
		ifelse(length(m.direct)==0, TRUE, FALSE)
}