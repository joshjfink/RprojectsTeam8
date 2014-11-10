read_graph = function(file){
  graph = as.matrix(read.table(file, fill = TRUE), ncol = 4)
  graph = subset(graph, select = -c(V2) ) # drop "->"
  graph = sub(".*?weight=(.*?)].*", "\\1", graph)
  graph = sub(";", "\\1", graph)
  for (i in dim(graph2)[1]){
    if (is.null(graph[i,])[3]){
      g[[i]] = list(edges = as.character(graph[i,][2]))
    } else{
      g[[i]] = list(edges = as.character(graph[i,][2]), weights = as.numeric(graph[i,])[3])
    }
  }
  
  return(g)
}