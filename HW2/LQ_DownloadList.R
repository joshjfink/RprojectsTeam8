# Load Required packages
source("check_packages.R")
check_packages(c("httr", "stringr"))

# Define URL
url = "http://www.lq.com/en/findandbook/hotel-listings.html"

page = GET(url)

s = content(page, as="text")

dir.create("lq/", showWarnings = FALSE)

# Write List File
write(s, file="lq/list.html")


	