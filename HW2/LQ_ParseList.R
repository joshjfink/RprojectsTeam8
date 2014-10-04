check_packages = function(names)
{
    for(name in names)
    {
        if (!(name %in% installed.packages()))
            install.packages(name, repos="http://cran.us.r-project.org")
    
        library(name, character.only=TRUE)
    }
}
check_packages(c("httr", "stringr"))
d = data.frame(name= "La Quinta Inn & Suites Flagstaff",
               url = "http://www.lq.com/en/findandbook/hotel-details.flagstaff.address.html",
               stringsAsFactors = FALSE)

attach(d)
page = GET(url)
s = content(page, as="text")
write(s, file="lq/flag.html") 

# Address, Phone and Fax
contact_info = str_match_all(s, "<p>+([0-9][0-9a-zA-Z ]*), <br/>[ \r\n]*([A-Za-z0-9, ]*)[ \r\n<br/>]*Phone: ([ 0-9-]*)[ \r\n<br/>]*Fax: ([ 0-9-]*)")[[1]][,2:5]
add_num <- contact_info[1]
add_csz <- contact_info[2]
phone <- contact_info[3]
fax <- contact_info[4]
# latitude, and longitude
lat_lon = str_match_all(s, "green.gif|[-]*[0-9]*[.][0-9]*,[-]*[0-9]*[.][0-9]*")[[1]][2,] 
