## Code to retrieve data that was tidied and created in project 1
library(tidyverse)

counts_area_sl <- read.csv("project1_data/counts_area_sl.txt")

counts_area_sl <- counts_area_sl %>% select(-X)

counts_area_sl$LatCat2 <- ifelse(counts_area_sl$Latitude < 25, "20-25", 
                          ifelse(counts_area_sl$Latitude < 30, "25-30", 
                          ifelse(counts_area_sl$Latitude < 35, "30-35", 
                          ifelse(counts_area_sl$Latitude < 40, "35-40", 
                          ifelse(counts_area_sl$Latitude < 45, "40-45", 
                          ifelse(counts_area_sl$Latitude < 50, "45-50", 
                          ifelse(counts_area_sl$Latitude < 55, "50-55",
                          ifelse(counts_area_sl$Latitude < 60, "55-60",
                          ifelse(counts_area_sl$Latitude < 65, "60-65","65-70"))))))))) 
