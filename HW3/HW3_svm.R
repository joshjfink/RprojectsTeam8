###############################
############ Setup ############
###############################
# Load packages
source("check_packages.R")
check_packages(c("devtools", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK", "date", "lubridate", "Rcpp","sp", "mvoutlier","e1071","raster"))


# Install updated devtools from GitHub repo to prevent crash
if (compareVersion(toString(packageVersion("dplyr")), "0.3.0.9000") == -1) {
  devtools::install_github("hadley/dplyr")
}
require(dplyr)

################################
############ Task 1 ############
################################
# Read in data
### This read in small data for sake of testing
dat.master = tbl_df(read.csv("/home/vis/cr173/Sta523/data/parking/NYParkingViolations.csv",stringsAsFactors=FALSE))

#choose right issue date & correct precincts
dat.master$Issue.Date = mdy(dat.master$Issue.Date)
dat.subset = filter(dat.master, Issue.Date > "2013/09/01" & Issue.Date < "2014/6/30" & (Violation.Precinct == 1 | Violation.Precinct == 5 | Violation.Precinct == 6 | Violation.Precinct == 7 | Violation.Precinct == 9 | Violation.Precinct == 10 | Violation.Precinct == 13 | Violation.Precinct == 14 | Violation.Precinct == 17 | Violation.Precinct == 18 | Violation.Precinct == 19 | Violation.Precinct == 20 | Violation.Precinct == 22 | Violation.Precinct == 23 | Violation.Precinct == 24 | Violation.Precinct == 25 | Violation.Precinct == 26 | Violation.Precinct == 28 | Violation.Precinct == 30 | Violation.Precinct == 32 | Violation.Precinct == 33 | Violation.Precinct == 34))

# Select and clean addresses
addr <- select(dat.subset, Street.Code1, Street.Code2, Street.Code3, Street.Name, Intersecting.Street, House.Number, Violation.Precinct) %>% mutate(House.Number = str_trim(House.Number)) %>%
  filter(House.Number != "" & Street.Name != "") %>%
  filter(str_detect(House.Number,"[0-9]+")) %>%
  mutate(Street.Name = toupper(Street.Name)) %>%
  mutate(Street.Name = str_replace(Street.Name,"TH "," ")) %>%
  mutate(Street.Name = str_replace(Street.Name, "([0-9]+)ST","\\1")) %>%
  mutate(Street.Name = str_replace(Street.Name, "([0-9]+)RD","\\1")) %>%
  mutate(Street.Name = str_replace(Street.Name, "([0-9]+)ND","\\1")) %>%
  mutate(Street.Name = str_trim(Street.Name)) %>%
  transmute(Violation.Precinct = Violation.Precinct, addr = paste(House.Number, Street.Name)) %>%
  mutate(addr = toupper(addr))


base = '/home/vis/cr173/Sta523/data/parking'
pl = readOGR(paste0(base,"/pluto/Manhattan/"),"MNMapPLUTO")

pt = gCentroid(pl,byid=TRUE)
tax = cbind(data.frame(pt@coords), as.character(pl@data$Address))
names(tax)[3] = "addr"
z = inner_join(addr, tax)
##will delete later, don't need to rerun them
write.csv(z,file="raw data with outlier.csv")

#### Remove outliers using mvoutlier package
outs <-  na.omit(data.matrix(z[,2:4]))
x.out=sign2(outs,makeplot=FALSE)
summary(x.out)
addr2 <- tbl_df(cbind(data.frame(Out=x.out$wfinal01), outs))
addr <- filter(addr2, Out==1) %>%
  select(Violation.Precinct, x, y)
##will delete later, don't need to rerun them
write.csv(addr,file="data without outlier.csv")

################################
############ Task 2 ############
################################

#SVM
k=svm(as.factor(Violation.Precinct)~.,data=addr,cross=5)
plot(k,data=s)

nybb = readOGR(path.expand("/home/vis/cr173/Sta523/data/parking/nybb/"),"nybb",stringsAsFactors=FALSE)
manh = nybb[2,]

library(raster)
r = rasterize(manh, raster(ncols=500,nrows=1000,ext=extent(bbox(manh))))


cells = which(!is.na(r[]))
crds = xyFromCell(r,cells)

z = predict(k,crds)

r[cells] = as.numeric(as.character(z))

dist = sort(unique(addr$Violation.Precinct))

l=list()
for(i in seq_along(dist))
{
  l[[i]] = rasterToPolygons(r, function(x) x==dist[i], dissolve=TRUE)
  l[[i]]@polygons[[1]]@ID = as.character(dist[i])
  rownames(l[[i]]@data) = dist[i]
  colnames(l[[i]]@data) = "Precinct"
}

pd = do.call(rbind, l)

writeOGR(pd, "./out", "", driver="GeoJSON")
file.rename("./out", "./precinct_svm.json")


# alpha affects alpha blending (makes things transparent), useful if polys may overlap
plot(pd,main = "precinct_svm.json", axes=TRUE, col=adjustcolor(2:6,alpha=0.5))

dev.off()