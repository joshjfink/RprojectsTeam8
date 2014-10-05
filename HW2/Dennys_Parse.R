# Do parsing stuff
#
library(XML)
library(RCurl)

AllStates = c(state.abb) #All 50 states
dennys = data.frame(matrix(vector(), 0, 13, dimnames=list(c(), c("name","address1","address2","city","clientkey","country","latitude","longitude","other","phone","postalcode","state","uid"))), stringsAsFactors=F)

for (n in 1:50){
  state = AllStates[n]
  fileName = paste("Dennys_",state,".xml",sep = "")
  doc <- xmlParse(fileName)
  dennys.state = xmlToDataFrame(nodes=getNodeSet(doc,"//poi"))[c("name","address1","address2","city","clientkey","country","latitude","longitude","other","phone","postalcode","state","uid")]
  dennys <- rbind(dennys, dennys.state)
}
newdennys <- dennys[order(dennys$uid),] 
dennys <- unique(newdennys)
dennys <- dennys[order(dennys$state),] 

save(dennys, file="dennys/dennys_data.Rdata")

# We pulled 1000 locations from each state, did it for all 50 states. For result, we have a total number ~50k locations. 
# However after we remove the duplicate rows. It's only 1698 locations left. We think the method pull all states is very inefficient. 
# If we have time to redo it for this specific case, it would be better just pull a few states. But the risk is missing some locations.