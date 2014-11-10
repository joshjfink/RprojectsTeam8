read_graph = function(file){
  graph = as.matrix(read.table(file, fill = TRUE), ncol = 4)
  graph = subset(graph, select = -c(V2) ) # drop "->"
  graph = sub(".*?weight=(.*?)].*", "\\1", graph)
  graph = sub(";", "\\1", graph)
  
  
  
  return(g)
}