
source("check_packages.R")

check_packages(c("dplyr", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK", "date", "lubridate"))

# Read in data
dat.master = tbl_df(read.csv("/home/vis/cr173/Sta523/data/parking/NYParkingViolations.csv",stringsAsFactors=FALSE))

#choose right issue date & correct precincts
dat.master$Issue.Date = mdy(dat.master$Issue.Date)
dat.subset = filter(dat.master, Issue.Date > "2013/09/01" & Issue.Date < "2014/6/30" & (Violation.Precinct == 5 | Violation.Precinct == 6 | Violation.Precinct == 7 | Violation.Precinct == 9 | Violation.Precinct == 10 | Violation.Precinct == 13 | Violation.Precinct == 14 | Violation.Precinct == 17 | Violation.Precinct == 18 | Violation.Precinct == 19 | Violation.Precinct == 20 | Violation.Precinct == 22 | Violation.Precinct == 23 | Violation.Precinct == 24 | Violation.Precinct == 25 | Violation.Precinct == 26 | Violation.Precinct == 28 | Violation.Precinct == 30 | Violation.Precinct == 32 | Violation.Precinct == 33 | Violation.Precinct == 34))

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



  
