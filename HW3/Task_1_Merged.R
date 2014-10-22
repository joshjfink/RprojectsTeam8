# Setup
source("check_packages.R")
check_packages(c("devtools", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK", "date", "lubridate", "Rcpp","sp"))

# Install updated devtools from GitHub repo to prevent crash
devtools::install_github("hadley/dplyr")
require(dplyr)

# Read in data
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

#############task 2###############

#build suitable data frame
z1 = as.matrix(data.table(z[,2:4],key = "Violation.Precinct"))
rownames(z1) = as.matrix(z1[,1])
z1 = z1[,-1]

#build convex hull for each precinct
spt = SpatialPoints(z1)
spoly = gConvexHull(spt,byid = TRUE)

#transform it to SpatialPolygonsDataFrame
data = data.frame(precinct = sapply(spoly@polygons, function(x) x@ID),stringsAsFactors=FALSE)
spoly = SpatialPolygonsDataFrame(spoly, data, match.ID=FALSE)

writeOGR(spoly, "./out", "", driver="GeoJSON") # Creates out file, current version of 

#rename the file afterwards
file.rename("./out", "./precinct.json")


# alpha affects alpha blending (makes things transparent), useful if polys may overlap
plot(spoly,main = "precinct.json", axes=TRUE, col=adjustcolor(2:6,alpha=0.5))

dev.off()