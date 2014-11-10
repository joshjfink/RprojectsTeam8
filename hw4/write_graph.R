write_graph = function(g, file){
  if(is.list(g)){
    if(is_valid(g)){
      file.create(file, showWarnings = TRUE)
      match = c(names(g), seq(1, length(g), by=1))
      for (i in 1:length(g)){
        FROM = names(g[i])
        if(grepl(" ", FROM)){
          FROM = paste('"', FROM,'"', sep="")
        }
        if (length(g[[i]]$edges) > 0){
          TO.List = match[g[[i]]$edges]
          WEIGHT.List = g[[i]]$weights
          for (j in 1:length(g[[i]]$edges)){
            TO = TO.List[j]
            if(grepl(" ", TO)){
              TO = paste('"', TO,'"', sep="")
            }
            WEIGHT = WEIGHT.List[j]
            WirteToDot = paste(FROM, "->", TO)
            AddWeight = paste(" [weight=", WEIGHT, "]", sep="")
            if (is.null(WEIGHT.List)){
              WirteToFile = paste(WirteToDot, ";", sep="")
              write(WirteToFile, file = file, ,append = TRUE)
            } else{
              WirteToFile = paste(WirteToDot, AddWeight, ";", sep="")
              write(WirteToFile, file = file, ,append = TRUE)
            }
          }
        } else{
          WirteToFile = paste(FROM, ";", sep="")
          write(WirteToFile, file = file, ,append = TRUE)
        }
      }
    } else{
      return("error")
    }
  }
}