load(url(paste0("https://github.com/robertwwalker/rww-science/raw/master/content/R/COVID/data/OregonCOVID",Sys.Date()-2,".RData"))) # 1
library(rvest); library(htmltools); library(tidyverse); library(rlang)
# A function to remove commas from numbers.
comma.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, ",")) 
}
dash.rm.to.numeric <- function(variable) {
  as.numeric(str_remove_all( {{variable}}, "-")) 
}
June67.Counties <- read.csv("content/R/COVID/data/June672020.csv") # The data are in an easily cut and pasted table
June67.COVID <- June67.Counties %>% mutate(Number.of.cases = Cases1, Deaths = Deaths2, Negative.test.results = Negatives3, date=as.Date(date), Scraped.date = as.Date(Scraped.date)) %>% select(County, Number.of.cases, Deaths, Negative.test.results, date, Scraped.date)
Tests.Merge <- June67.Counties %>% filter(County == "Total") %>% mutate(`Total deaths` = Deaths2, `Total persons tested` = Cases1 + Negatives3, Positive = Cases1, Negative = Negatives3) %>% select(`Total deaths`, `Total persons tested`, date, Scraped.date, Positive, Negative) %>% pivot_longer(., cols=c(Positive,Negative,`Total persons tested`,`Total deaths`), values_to = "Outcome", names_to = "Category") %>% mutate(date = as.Date(date), Scraped.date = as.Date(Scraped.date))
Oregon.Tests.All <- bind_rows(Tests.Merge,Oregon.Tests.All)
  # Drop the row of totals and other things.
Oregon.Tests <- Oregon.Tests.All[!str_detect(Oregon.Tests.All$Category, "Total"),]  # 6
  # Create a summary table
OR.Testing <- Oregon.Tests %>% group_by(date) %>% summarise(Total = sum(Outcome)) # 6
  # Create county data
Oregon.COVID.All <- Oregon.COVID.All %>% bind_rows(Oregon.COVID.All, June67.COVID) %>% unique.data.frame()
Oregon.COVID.Total <- Oregon.COVID.All %>% filter(County=="Total") # 6
Oregon.COVID <- Oregon.COVID.All %>% filter(County!="Total")  # 6
save.image(paste0("~/Sandbox/awful/content/R/COVID/data/OregonCOVID",Sys.Date(),".RData")) # Save the data with a date flag in the name.
