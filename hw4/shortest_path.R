#Input - g, graph object; v1, a vertex label in g; v2, a vertex label in g.

#Output - a vector of the names (or indexes if unlabeled) of vertexes that make up the shortest path, in order.

#Description - Find the shortest path from vertex v1 to vertex v2 using the edges of graph g. Note that there may not be a unique solution for any given graph, you are only required to return one path.

shortest_path = function(g,v1,v2)
{
  path_len = function(m,visited)
  {
    if(length(visited)==0||length(visited)==1) return(Inf)
    len = 0
    for (i in 1:(length(visited)-1))
      len = len + m[visited[i],visited[i+1]]
    return (len)        
  }
  
  short_path = function(v1, v2, m, visited=integer())
  {
    if(v1==v2) return(v1)
    gname = rownames(m)
    if(length(setdiff(gname,c(v2,visited)))==1){
      if(path_len(m,c(v1,v2))!=Inf) return(c(v1,v2))
      else return(NULL)
    }
    min = Inf; ind = NULL
    rest = setdiff(gname,c(visited,v2))
    visited = c(v2,visited)
    for (i in 1:length(rest)) {
      if(rest[i]==v1&&min>path_len(m,c(v1,v2))) {min = path_len(m,c(v1,v2));ind = v1;next}   
      if(is.null(short_path(v1,rest[i],m,visited))) next
      potential = path_len(m,short_path(v1,rest[i],m,visited))+m[rest[i],visited[1]]
      if(min>potential) 
      {ind = rest[i]
       min = min(min,potential)}
    }
    if(is.null(ind)) return(NULL)
    return(c(short_path(v1,ind,m,visited),v2))
  }
  if(is.character(v1)==F)v1=names(g)[v1]
  if(is.character(v2)==F)v2=names(g)[v2]
  source("is_valid.R")
  stopifnot(is_valid(g))
  source("min_span_tree.R")
  m = get_adj_mat2(g)
  visited = integer()
  if (v1 %in% visited) break;
  visited = short_path(v1,v2,m)
  return(visited)
}
      
      