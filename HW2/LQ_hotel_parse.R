source("check_packages.R")
check_packages(c("httr", "stringr"))

# Create list of files
f <- list.files(path="lq/hotels", pattern="*.html", full.names=T, recursive=FALSE)
#Contact Info (Address, phone, fax)
contact <- sapply(f, function(x){
	a <- readLines(x)
	b <- paste(a, collapse = "")
	str_match_all(b, "<p>+([0-9][0-9a-zA-Z ]*), <br/>[ \r\n]*([A-Za-z0-9, ]*)[ \r\n<br/>]*Phone: ([ 0-9-]*)[ \r\n<br/>]*Fax: ([ 0-9-]*)")
})
add1 <- add2 <- phone <- fax <- NULL
for(i in 1:length(contact)){
	add1[i] <- ifelse(class(contact[[i]]) =="character", "NA", contact[[i]][,2])
	add2[i] <- ifelse(class(contact[[i]]) =="character", "NA", contact[[i]][,3])
	phone[i] <- ifelse(class(contact[[i]]) =="character", "NA", contact[[i]][,4])
	fax[i] <- ifelse(class(contact[[i]]) =="character", "NA", contact[[i]][,5])
}
# Lattitude and Longitude
lat_lon <- sapply(f, function(x){
	a <- readLines(x)
	b <- paste(a, collapse = "")
	str_match_all(b, "green.gif|[-]*[0-9]*[.][0-9]*,[-]*[0-9]*[.][0-9]*")
})
lat_lon <- unique(unlist(lat_lon))

