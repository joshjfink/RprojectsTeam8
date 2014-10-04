# Do parsing stuff


# df of Hotel names and urls
d = data.frame(name= "La Quinta Inn & Suites Flagstaff",
               url = "http://www.lq.com/en/findandbook/hotel-details.flagstaff.address.html",
               stringsAsFactors = FALSE) 


# get hotel name and link

Name = str_match_all(s, "html\">([A-Za-z0-9'\\() /&\\.-]*)</a><br>\r\n")
link = str_match_all(s, "<a href=\"([a-z0-9 \\/\\.-]*)\">La Quinta")
Name = unlist(Name)
Name = Name[(length(Name)/2+1):length(Name)]
link = unlist(link)
link = link[(length(link)/2+1):length(link)]
link = paste0("http://www.lq.com",link)
#the number of link and name are different, and hard to match, so what do you think if we can gather the name in the next step?
link = unique(link)
Name = unique(Name)

# Save results as Rdata file
save(link, file="lq/list.Rdata")
