# Check Packages Function
check_packages = function(names)
{
    for(name in names)
    {
        if (!(name %in% installed.packages()))
            install.packages(name, repos="http://cran.us.r-project.org")
    
        library(name, character.only=TRUE)
    }
}

# Load Required Packages
check_packages(c("httr"))

# Define URL
url = "http://www.lq.com/en/findandbook/hotel-listings.html"

page = GET(url)

s = content(page, as="text")

dir.create("lq/", showWarnings = FALSE)

# Write List File
write(s, file="lq/list.html")