#assume data contains longitude, latitude and # of precinct
check_packages(c("dplyr", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK"))

# To read GeoJSON must use OGRGeoJSON as layer
p = readOGR("precinct_in.json","OGRGeoJSON") 
source("hw3_merge_ex.R")

#Make use of the organization of p, directly change the data of p to represent the information from z
#get the 4 vertex of each precinct
z1 = z %>% group_by(Violation.Precinct) %>% summarize(min(x), min(x),min(y),max(y))
z1 = z1 %>% mutate(coords = matrix(mix(x), mix(y), mix(x), max(y), max(x), min(y), max(x), max(y)),nrow = 5, ncol = 2)

#but the problem for this idea is that it can only represent a rectangular rather than a polygon
count = unique(z$Violation.Precinct)
p$precinct = count 
#some of codes cannot run

# Write to GeoJSON
writeOGR(p, "./out", "", driver="GeoJSON") # Creates out file, current version of 
# GDAL does not allow . in file names 
# so we have to rename the file afterwards
file.rename("./out", "./precinct.json")

p2 = readOGR("precinct.json","OGRGeoJSON") 

# Compare results
pdf("plot.pdf",width=10,height=5)

par(mfrow=c(1,2))

# alpha affects alpha blending (makes things transparent), useful if polys may overlap
plot(p,main = "precinct_in.json", axes=TRUE, col=adjustcolor(2:6,alpha=0.5))
plot(p2,main = "precinct.json", axes=TRUE, col=adjustcolor(2:6,alpha=0.5))

dev.off()