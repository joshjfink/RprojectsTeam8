#### 
# Setup
####

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


# Input - g, a graph object.
# Output - true if valid, false if not.
# Description - Validate the graph object to ensure that it meets all requirements -      
test_that("is_valid", {
	is.list(g)
})

expect_true(is.list(g))


test_that("string tests", {
  str1 = "Hello World!"
  str2 = totitle(str1)
  str3 = totitle(tolower(str2))
  str4 = totitle(toupper(str3))

  expect_equal(str1, str2)
  expect_equal(str1, str3)

# Check that object is a list of lists.


# Check if there are names for the primary list that they are all unique.


# Check that each secondary list contains only edges and weights vectors that are of the appropriate type.


# Check that there are not any edges to non-existent vertices.


# Check that all weights are not less than or equal to 0.


# Check that every edge has a weight.
str(graph2)


g <- graph2
  

ifelse(is.list(g)
lapply(g, function(x){
  names(x)
  is.list(x)
})



length(g)




shortest_path = function(g, v1, v2)
{

    return(c("A","B"))
}


Function - is_valid
Function - is_undirected
Function - is_isomorphic