set.seed(123)
d = data.frame(matrix(rnorm(1e6 * 10),ncol=10))
d$cat = sample(LETTERS[1:5], 1e6, replace=TRUE)
d <- d[,1:10]
# sub.d <-d[1:1000,]
for1 <- NULL
single.for.loop = function(D, D2=as.matrix(D), for1 = NULL)
  for (i in 1:nrow(D2)) {
    for1[i] = max(D2[i,])
    # print(for1)
  }

single.for.loop(d)
