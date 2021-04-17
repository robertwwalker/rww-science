load(url(paste0("https://github.com/robertwwalker/rww-science/raw/master/content/R/COVID/data/OregonCOVID",Sys.Date()-1,".RData"))) # 1
library(rvest); library(htmltools); library(tidyverse); library(rlang)
# A function to remove commas from numbers.
comma.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, ",")) 
}
dash.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, "-")) 
}
# A function to parse the tables currently
OHA.Corona <- function(website, date) {
  webpage <- read_html(website) # 1
  COVID.Head <- webpage %>%
    html_nodes("table") %>% # 2
    .[1] %>%  # Grab the first table
    html_table(fill = TRUE) %>%  # 3
    data.frame()  # 4 
  # Acquire the scraped date from the heading on the page.  The rest is 5
  Scraped.date <- names(COVID.Head)[1] %>% str_remove(.,"X.As.of.") %>% str_remove(., "..8.00.a.m..Updated.daily.")
  names(COVID.Head) <- c("Category","Outcome") # Change the names
  COVID.Head <- COVID.Head %>% 
    mutate(Outcome = comma.rm.to.numeric(Outcome), date=as.Date(date), Scraped.date = as.Date(Scraped.date,"%m.%d.%y")) # Create a few variables including the date for checking
  # Extract the county data
  COVID.County <- webpage %>%
    html_nodes("table") %>% # 2
    .[2] %>%
    html_table(fill = TRUE) %>% # 3 
    data.frame() %>%  # 4
    mutate(date=as.Date(date), # 5
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y"), 
           Negative.test.results = Negative,
           Deaths = Deaths.,
           Number.of.cases = Positive.)
  # Extract the age data
  COVID.Age <- webpage %>%
    html_nodes("table") %>% #2
    .[3] %>%
    html_table(fill = TRUE) %>% # 3 
    data.frame()  %>%   # 4
    mutate(Cases = dash.rm.to.numeric(Cases)) %>%
    mutate(date=as.Date(date), 
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y"), 
           Hospitalized = dash.rm.to.numeric(Ever.hospitalized.), 
           Deaths = dash.rm.to.numeric(Deaths.),
           Number.of.cases = Cases) %>% 
    select(-c(Ever.hospitalized.,Deaths.)) # 5
  # Extract the age data
  COVID.Gender <- webpage %>%
    html_nodes("table") %>% #2
    .[4] %>%
    html_table(fill = TRUE) %>% # 3 
    data.frame()  %>%   # 4
    mutate(date=as.Date(date), 
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y"), 
           Deaths = dash.rm.to.numeric(Deaths.)) %>% select(-Deaths.) # 5
  # Extract the hospitalization data
  COVID.Hospitalized <- webpage %>%
    html_nodes("table") %>% # 2
    .[5] %>%
    html_table(fill = TRUE) %>% # 3
    data.frame()  %>%  # 4
    mutate(date=as.Date(date), 
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y"),
           Number.of.cases = Cases) # 5
  # Extract the hospital capacity data
  COVID.Hospital.Cap <- webpage %>%
    html_nodes("table") %>% # 2
    .[6] %>%
    html_table(fill = TRUE) %>% # 3
    data.frame()  %>%  # 4
    mutate(date=as.Date(date), 
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y")) %>% 
           pivot_longer(c(Available, Total), names_to = "Hospital.Capacity", values_to = "Number") # 5
  COVID.Strain <- webpage %>%
    html_nodes("table") %>% # 2
    .[7] %>%
    html_table(fill = TRUE) %>% # 3
    data.frame()  %>%  # 4
    mutate(date=as.Date(date), 
           Scraped.date = as.Date(Scraped.date,"%m.%d.%y")) # 5
  return(list(Header=COVID.Head, Counties = COVID.County, Gender = COVID.Gender, Ages = COVID.Age, Hospitalized = COVID.Hospitalized, Hospital.Cap=COVID.Hospital.Cap, COVID.Strain = COVID.Strain))
}
Today <- OHA.Corona(website="https://govstatus.egov.com/OR-OHA-COVID-19", date=as.character(Sys.Date())) # 2
if(max(Oregon.COVID$Scraped.date) < as.Date(Today$Header$Scraped.date[[1]],"%m.%d.%y")) { # 3
  # Store Today
  eval(parse_expr(paste(months(Sys.Date()),format(Sys.Date(), "%d")," <- Today", sep=""))) # 4
  # Create test data
  Oregon.Tests.All <- bind_rows(Today$Header,Oregon.Tests.All) %>% distinct(.) # 5
  # Drop the row of totals and other things.
  Oregon.Tests <- Oregon.Tests.All[!str_detect(Oregon.Tests.All$Category, "Total"),]  # 6
  # Create a summary table
  OR.Testing <- Oregon.Tests %>% group_by(date) %>% summarise(Total = sum(Outcome)) # 6
  # Create county data
  Oregon.COVID.All <- bind_rows(Today$Counties,Oregon.COVID.All) %>% distinct(.) # 5
  # Split the county data into one that is exclusively totals and one without the totals
  Oregon.COVID.Total <- Oregon.COVID.All %>% filter(County=="Total") # 6
  Oregon.COVID <- Oregon.COVID.All %>% filter(County!="Total")  # 6
  # Create the data by age
  OR.Ages <- bind_rows(Today$Ages,OR.Ages)  %>% filter(Age.group!="Total") %>% distinct(.) # 5
  # Create a summary table by age
  OR.AgeT <- OR.Ages %>% group_by(date) %>% summarise(Total=sum(Number.of.cases)) # 6
  # Create the hospitalization data
  OR.Hosp <- bind_rows(Today$Hospitalized,OR.Hosp) %>% distinct(.) # 5
  # Create the gender data
#  OR.Gender <- Today$Gender
  OR.Gender <- bind_rows(Today$Gender, OR.Gender) %>% distinct(.) # 5
# Create the hospital capacity data
#  OR.Hospital.Caps <- Today$Hospital.Cap
  OR.Hospital.Caps <- bind_rows(Today$Hospital.Cap, OR.Hospital.Caps) %>% distinct(.) # 5 
# Integrate the COVID Strain on Hospitals
  OR.COVID.Strain <- bind_rows(Today$COVID.Strain, OR.COVID.Strain) %>% distinct(.) # 5 
# Save the imageformat(Sys.Date(), "%d")
#  save.image(paste0("~/Sandbox/awful/content/R/COVID/data/OregonCOVID",Sys.Date(),".RData")) # Save the data with a date flag in the name.
  cat(paste0("Added new data... \n",Sys.time())) # Report the updates
} else {
  cat(paste0("Nothing new to add; have a nice day! \n",Sys.time())) # Report no updates.
}
paste0(Sys.time()) # Show when we were updated.
