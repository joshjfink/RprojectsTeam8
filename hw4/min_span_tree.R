##use prim algrithm##
#input - g, graph object.

#Output - a graph object (undirected) containing the minimum spanning tree

#Description - A tree is an undirected graph in which any two vertices are connected by exactly one path (no simple cycles). Therefore, a minimum spanning tree is the tree that connects all vertices in a graph with the shortest possible total of edges, using the existing edges. If given a directed graph return an error. Note that there may not be a unique solution for any given graph, you are only required to return one tree.

###### Graph for Testing
# # Test Graph
# g = list(A = list(edges   = c(2L,3L),
#                        weights = c(14,10)),
#          B = list(edges   = c(1L,3L,4L,5L),
#                        weights = c(14,7,4,11)),
#          C = list(edges   = c(1L,2L,4L,5L),
#                        weights = c(10,7,5,9)),
#          D = list(edges   = c(2L,3L),
#                        weights = c(4,5)),
#          E = list(edges   = c(2L,3L),
#                        weights = c(11,9)))

get_adj_mat2 = function(g, trans_mat=FALSE)
{
  
  n = length(g)
  m = matrix(Inf, ncol=n, nrow=n)
  
  colnames(m) = names(g)
  rownames(m) = names(g)
  
  for(i in 1:n)
    m[i, g[[i]]$edges] = ifelse(array(length(g[[i]]$weights)==0,length(g[[i]]$edges)),0,ifelse(array(trans_mat,length(g[[i]]$edges)), g[[i]]$weights/sum(g[[i]]$weights), g[[i]]$weights))
  
  return(m)
}

add_vertex = function(from,to,weight,g_new=g_new)
{
  to_num = as.integer(which(to==names(g)))
  from_num = as.integer(which(from==names(g)))
  g_new[[from]]$edges=c(g_new[[from]]$edges,to_num)
  g_new[[to]]$edges=c(g_new[[to]]$edges,from_num)
  g_new[[from]]$weights=c(g_new[[from]]$weights,weight)
  g_new[[to]]$weights=c(g_new[[to]]$weights,weight)
  return(g_new)
}

min_span_tree = function(g)
{
  
  stopifnot(is_undirected(g))
  
  n = length(g)
  m = get_adj_mat2(g)
  gname = names(g)
  g_new = lapply(g,FUN=function(x) x=list(edges = c(),weights = c()))
  
  pois.min = which.min(m)
  val.min = min(m)
  U = rownames(m)[c(pois.min%%n,pois.min%/%n+1)]
  V = setdiff(rownames(m),U)
  GE = c(val.min)
  g_new = add_vertex(U[1],U[2],GE[1],g_new)
  
  lowcost = array(Inf,n)
  adjvex = array(Inf,n)
  rownames(lowcost) = rownames(adjvex) = rownames(m)
  
  for (i in 1:length(V))
  {
    potential = c(adjvex[V[i]], which(gname==U[1]),which(gname==U[2]))
    adjvex[V[i]] = potential[which.min(c(lowcost[V[i]],m[U[1],V[i]],m[U[2],V[i]]))]
    lowcost[V[i]] = min(lowcost[V[i]],m[U[1],V[i]],m[U[2],V[i]])
  }
  
  repeat{
    if(length(V)==0) break;
    GE = c(GE,min(lowcost))
    g_new = add_vertex(gname[adjvex[which.min(lowcost)]],gname[which.min(lowcost)],min(lowcost),g_new)
    U = c(U,gname[which.min(lowcost)])
    len_U = length(U)
    V = setdiff(rownames(m),U)
    lowcost[U[len_U]]=adjvex[U[len_U]]=Inf
    if(length(V)==0) break;
    for (i in 1:length(V))
    {
      potential = c(adjvex[V[i]], which(gname==U[len_U]))
      adjvex[V[i]] = potential[which.min(c(lowcost[V[i]],m[U[len_U],V[i]]))]
      lowcost[V[i]] = min(lowcost[V[i]],m[U[len_U],V[i]])
    }
  }
  
  return(g_new)    
}