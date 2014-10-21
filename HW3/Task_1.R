
source("check_packages.R")

check_packages(c("dplyr", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK", "date", "lubridate"))

#subset data
dat.master = tbl_df(read.csv("/home/vis/cr173/Sta523/data/parking/NYParkingViolations_small.csv",stringsAsFactors=FALSE))

#choose right issue date
dat.master$Issue.Date = mdy(dat.master$Issue.Date)
dat.subset = filter(dat.master, Issue.Date > "2013/09/01", Issue.Date < "2014/6/30")

#choose the correct precincts
dat.subset = filter(dat.master, Violation.Precinct <= 34)

#@ should seperate intersecting and street name
sep_streets <- dat.subset %>%
  filter(str_detect(Street.Name,"@")) %>%
  mutate(Street.Name = paste(Street.Name, " ")) %>%
  separate(Street.Name, c("Street.Name", "a2"), sep = "@") 

dat.subset <- select(dat.subset, Street.Code1, Street.Code2, Street.Code3, Street.Name, Intersecting.Street, House.Number, Violation.Precinct) %>%
mutate(Intersecting.Street=ifelse(str_detect(Street.Name,"@"), paste(sep_streets$a2, Intersecting.Street), Intersecting.Street)) %>%
mutate(Street.Name=ifelse(str_detect(Street.Name,"@"), sep_streets$Street.Name, Street.Name))



