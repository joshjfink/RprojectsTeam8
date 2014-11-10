is_connected = function(g, v1, v2){
  if(is.list(g)){
    if(is_valid(g)){
      match = c(names(g), seq(1, length(g), by=1))
      if(v1 %in% match & v2 %in% match){
        if(length(c(g[[v1]]$edges)) == 0){
          return(FALSE)
        } else{
          if(is.character(v1)){
            v1 = match(v1, names(g))
          }
          path = c(g[[v1]]$edges)
          name = NULL
          for (i in 1:length(g)){
            name = c(name, names(g)[path[i]])
            path = c(path, g[[path[i]]]$edges)
          }
          if(v2 %in% path | v2 %in% name){
            return(TRUE)
          } else{
            return(FALSE)
          }
        }
      } else{
        return("error")
      }
    } else{
      return("error")
    }
    
  } else{
    return("error")
  }
}