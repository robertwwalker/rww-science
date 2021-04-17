rm(list=ls())
load(paste0("~/Sandbox/awful/content/R/COVID/data/OregonCOVID",Sys.Date()-3,".RData")) # 1
library(rvest); library(htmltools); library(tidyverse); library(rlang)
# A function to remove commas from numbers.
comma.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, ",")) 
}
dash.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, "-")) 
}
Sept1213.Counties <- read.csv("content/R/COVID/data/Sept1213.csv", na.strings = "PENDING") # The data are in an easily cut and pasted table
Sept1213.COVID <- Sept1213.Counties %>% mutate(Number.of.cases = Cases1, Deaths = Total.deaths2, Negative.test.results = Negative.tests3, date=as.Date(date), Scraped.date = as.Date(Scraped.date)) %>% select(County, Number.of.cases, Deaths, Negative.test.results, date, Scraped.date)
Tests.Merge <- Sept1213.Counties %>% filter(County == "Total") %>% mutate(`Total deaths` = Total.deaths2, `Total persons tested` = Cases1 + Negative.tests3, Positive = Cases1, Negative = Negative.tests3, date=as.Date(date), Scraped.date = as.Date(Scraped.date)) %>% select(`Total deaths`, `Total persons tested`, date, Scraped.date, Positive, Negative) %>% pivot_longer(., cols=c(Positive,Negative,`Total persons tested`,`Total deaths`), values_to = "Outcome", names_to = "Category") %>% mutate(date = as.Date(date), Scraped.date = as.Date(Scraped.date))
Oregon.Tests.All <- bind_rows(Tests.Merge,Oregon.Tests.All)
# Drop the row of totals and other things.
Oregon.Tests <- Oregon.Tests.All[!str_detect(Oregon.Tests.All$Category, "Total"),]  # 6
# Create a summary table
OR.Testing <- Oregon.Tests %>% group_by(date) %>% summarise(Total = sum(Outcome)) # 6
# Create county data
Oregon.COVID.All <- Oregon.COVID.All %>% bind_rows(Oregon.COVID.All, Sept1213.COVID) %>% unique.data.frame()
Oregon.COVID.Total <- Oregon.COVID.All %>% filter(County=="Total") # 6
Oregon.COVID <- Oregon.COVID.All %>% filter(County!="Total")  # 6
save.image(paste0("~/Sandbox/awful/content/R/COVID/data/OregonCOVID",Sys.Date()-1,".RData")) # Save the data with a date flag in the name.
