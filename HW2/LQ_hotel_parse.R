source("check_packages.R")
check_packages(c("httr", "stringr"))

# Loop over hotels and download their pages
r <- NULL
for(i in 1:10)
{
    url = d[i,]
    page = GET(url)
    s = content(page, as="text")
    write(s, file=paste0("lq/hotels/",i,".html"))
    Sys.sleep(.3) # wait before grabbing the next page
}

# Create list of files
files <- list.files(path="lq/hotels", pattern="*.html", full.names=T, recursive=FALSE)
# testing subset
f <- t(files[1:10])
#Contact Info
contact <- sapply(f, function(x){
	a <- readLines(x)
	b <- paste(a, collapse = "")
	str_match_all(b, "<p>+([0-9][0-9a-zA-Z ]*), <br/>[ \r\n]*([A-Za-z0-9, ]*)[ \r\n<br/>]*Phone: ([ 0-9-]*)[ \r\n<br/>]*Fax: ([ 0-9-]*)")
})
contact_ <- sapply(contact, function(x){
	a <- unlist(x)
})
length(contact_)
add1 <- add2 <- phone <- fax <- NULL
for(i in 1:length(contact_)){
	add1[i] <- ifelse(class(contact_[[i]]) =="character", "NA", contact_[[i]][,2])
	add2[i] <- ifelse(class(contact_[[i]]) =="character", "NA", contact_[[i]][,3])
	phone[i] <- ifelse(class(contact_[[i]]) =="character", "NA", contact_[[i]][,4])
	fax[i] <- ifelse(class(contact_[[i]]) =="character", "NA", contact_[[i]][,5])
}
# Lattitude and Longitude
lat_lon <- sapply(f, function(x){
	a <- readLines(x)
	b <- paste(a, collapse = "")
	str_match_all(b, "green.gif|[-]*[0-9]*[.][0-9]*,[-]*[0-9]*[.][0-9]*")
})
lat_lon <- sapply(lat_lon, function(x){
	a <- unlist(x)
	a[nrow(a),]
})
lat_lon <- unique(latlon)
