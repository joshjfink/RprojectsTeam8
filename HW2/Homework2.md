---
title: "La Quinta and Dennys"
author: "team 8"
date: "10/5/2014"
output: html_document
---
### Visualization
***
This basic visualization gives one some ideas of what the macro-level patterns of La Quinta and Denny's locations look like. It does appear there is some correlation--although admittedly some of this is simply due to overall urbanization and the clustering of businesses in major cities.


```r
load(file="lq/hotel data.Rdata")
load(file="dennys/dennys_data.Rdata")

source("check_packages.R")
check_packages(c("maps", "mapdata","fields"))
```

```
## Warning: package 'maps' was built under R version 3.1.1
```

```
## Loading required package: methods
## Loading required package: spam
```

```
## Warning: package 'spam' was built under R version 3.1.1
```

```
## Loading required package: grid
## Spam version 1.0-1 (2014-09-09) is loaded.
## Type 'help( Spam)' or 'demo( spam)' for a short introduction 
## and overview of this package.
## Help for individual functions is also obtained by adding the
## suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
## 
## Attaching package: 'spam'
## 
## The following objects are masked from 'package:base':
## 
##     backsolve, forwardsolve
```

```r
# get the longitude and latitude information
lq_lat = as.numeric(hotel_data[,5])
lq_lon = as.numeric(hotel_data[,6])
de_lat = as.numeric(as.character(dennys$latitude))
de_lon = as.numeric(as.character(dennys$longitude))


map("state", interior = FALSE)
map("state", boundary = FALSE, col="gray", add = TRUE)
points(lq_lon,lq_lat, col = "blue", pch = 1.2)
points(de_lon,de_lat, col = "red", pch = 1.2)
title(main = "Map of US La Quinta and Denny's Locations")
```

![plot of chunk 1](figure/1.png) 

### Distance Analysis
***
Here  we perform basic calculations to summarize information on the distance between La Quinta and Denny's locations. Using 150 meters as a maximum threshold deinfing close proximity, we find 48 La Quinta locations next to Denny's, which many would consider quite high.


```r
# a distance matrix
distance = rdist.earth(cbind(de_lon,de_lat),cbind(lq_lon,lq_lat))

#calculate the closest hotel for each Denny's and the cloest Denny's for each hotel
MIN = function(x) c(which.min(x),min(x))
lq.min = apply(distance,2,MIN)
de.min = apply(distance,1,MIN)

#if the distance is smaller than 150 meters (= 0.0932057 mile), it should be thought of as "next to"
count = 0
dmin <- lq.min[2,]
for (i in 1:length(dmin)){
if(dmin[i] <0.0932057) count = count + 1
}
print(count)
```

```
## [1] 48
```
