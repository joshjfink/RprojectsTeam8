#assumeu data contains longitude, latitude and # of precinct
check_packages(c("dplyr", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK"))

# To read GeoJSON must use OGRGeoJSON as layer
source("task1.R")

#Make use of the organization of p, directly change the data of p to represent the information from z
#get the 4 vertex of each precinct
z1 = as.matrix(data.table(z[,2:4],key = "Violation.Precinct"))
rownames(z2) = as.matrix(z2[,1])
#contemporary code for testing
z2 = z2[,-1]
z2 = z2[-(1:5),]
z3 = matrix(c(-72,40.7),nrow = 1)
rownames(z3) = 22
z4 = rbind(z2,z3)

spt = SpatialPoints(z4)
spoly = gConvexHull(spt,byid = TRUE)





##codes we may use if we don't have enought data to construct a geopolgons
#s = paste0('
#{
 # "type": "FeatureCollection",
  #"features": [",
   #  {{
    #  "type": "Feature",
     # "geometry": {
      #  "type": "Polygon",
       # "coordinates": [
        #  [',
         #  apply(polygondraft[[1]]@Polygons[[1]]@coords,MARGIN = 1, function(x) paste0("[",x[1],",",x[2],"]",",")),
        #']
      #},
      #"properties": {
       # "precinct": ',polygondraft[[1]]@ID,
      #"}
    #},")
  
# Write to GeoJSON,cannot work now
spoly = as.dataframe(spoly)

writeOGR(spoly, "./out", "", driver="GeoJSON") # Creates out file, current version of 
# GDAL does not allow . in file names 
# so we have to rename the file afterwards
file.rename("./out", "./precinct.json")

p2 = readOGR("precinct.json","OGRGeoJSON") 

# alpha affects alpha blending (makes things transparent), useful if polys may overlap
plot(spoly,main = "precinct.json", axes=TRUE, col=adjustcolor(2:6,alpha=0.5))

dev.off()