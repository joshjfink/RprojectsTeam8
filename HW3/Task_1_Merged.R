source("check_packages.R")
check_packages(c("dplyr", "date", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK"))

base = '/home/vis/cr173/Sta523/data/parking'

#still has some merge problem between different R file, so firstly, we will read file separately.
park = tbl_df(read.csv(paste0(base,"/NYParkingViolations_small.csv"), stringsAsFactors=FALSE))
#choose right issue date
park$Issue.Date = mdy(park$Issue.Date)
park = filter(park, Issue.Date > "2013/09/01", Issue.Date < "2014/6/30")

####
#Conflicts codes deleted...

addr = filter(park, Violation.Precinct <= 34) %>%
       mutate(House.Number = str_trim(House.Number)) %>%
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


pl = readOGR(paste0(base,"/pluto/Manhattan/"),"MNMapPLUTO")

pt = gCentroid(pl,byid=TRUE)
tax = cbind(data.frame(pt@coords), as.character(pl@data$Address))
names(tax)[3] = "addr"

z = inner_join(addr, tax)