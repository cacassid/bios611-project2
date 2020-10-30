## Code to retrieve data that was tidied and created in project 1
library(tidyverse)

species <- read.csv("project1_data/species.csv")
parks <- read.csv("project1_data/datasets_670_1306_parks.csv")

## clean data sets 
parks$Acres <- as.numeric(parks$Acres)
parks$Latitude <- as.numeric(parks$Latitude)
parks$Longitude <- as.numeric(parks$Longitude)

#generate counts of species types for each park

s1 <- species %>% group_by(Park.Name, Category) %>% tally()

species_counts_all <- s1 %>% spread(data=s1, key=Category, value=n)

#convert to numeric 
species_counts_all$Algae <- as.numeric(as.character(species_counts_all$Algae))
species_counts_all$Amphibian <- as.numeric(as.character(species_counts_all$Amphibian))
species_counts_all$Bird <- as.numeric(as.character(species_counts_all$Bird))
species_counts_all$`Crab/Lobster/Shrimp` <- as.numeric(as.character(species_counts_all$`Crab/Lobster/Shrimp`))
species_counts_all$Fish <- as.numeric(as.character(species_counts_all$Fish))
species_counts_all$Fungi <- as.numeric(as.character(species_counts_all$Fungi))
species_counts_all$Insect <- as.numeric(as.character(species_counts_all$Insect))
species_counts_all$Invertebrate <- as.numeric(as.character(species_counts_all$Invertebrate))
species_counts_all$Mammal <- as.numeric(as.character(species_counts_all$Mammal))
species_counts_all$`Nonvascular Plant` <- as.numeric(as.character(species_counts_all$`Nonvascular Plant`))
species_counts_all$Reptile <- as.numeric(as.character(species_counts_all$Reptile))
species_counts_all$`Slug/Snail` <- as.numeric(as.character(species_counts_all$`Slug/Snail`))
species_counts_all$`Spider/Scorpion` <- as.numeric(as.character(species_counts_all$`Spider/Scorpion`))
species_counts_all$`Vascular Plant` <- as.numeric(as.character(species_counts_all$`Vascular Plant`))


#replace NA with 0
species_counts_all[is.na(species_counts_all)] <- 0

#merge species counts w/ size data
counts_area <- left_join(species_counts_all, parks)
#make small, medium, large park size variable
#get tertiles
quantile(counts_area$Acres, c(.25, .50, .75)) 
counts_area <- counts_area %>% mutate(Size = 
                                        ifelse(Acres > 323431, "Small", "Large"))
counts_area_sl <- counts_area %>% mutate(Size = Acres)
counts_area_sl$Size <- ifelse(counts_area$Acres < 69010.5, "Small", 
                              ifelse(counts_area$Acres < 238764.5, "Medium", 
                                     ifelse(counts_area$Acres < 817360.2, "Large", "Extra Large")))

counts_area_sl$LatCat2 <- ifelse(counts_area_sl$Latitude < 25, "20-25", 
                                 ifelse(counts_area_sl$Latitude < 30, "25-30", 
                                        ifelse(counts_area_sl$Latitude < 35, "30-35", 
                                               ifelse(counts_area_sl$Latitude < 40, "35-40", 
                                                      ifelse(counts_area_sl$Latitude < 45, "40-45", 
                                                             ifelse(counts_area_sl$Latitude < 50, "45-50", 
                                                                    ifelse(counts_area_sl$Latitude < 55, "50-55",
                                                                           ifelse(counts_area_sl$Latitude < 60, "55-60",
                                                                                  ifelse(counts_area_sl$Latitude < 65, "60-65","65-70"))))))))) 


#create data set to count species of different levels of conservation status by park
conservation <- species %>% group_by(Park.Name, Conservation.Status) %>% tally()
conservation$Conservation.Status[which(conservation$Conservation.Status == "")] = "No Concern"
conservation %>% rename(Status = Conservation.Status)
#convert from long to wide
conservation_wide <- conservation %>% spread(data=conservation, key=Conservation.Status, value=n)
#set empty to NA
conservation_wide$Breeder <- as.numeric(as.character(conservation_wide$Breeder))
conservation_wide$Endangered <- as.numeric(as.character(conservation_wide$Endangered))
conservation_wide$Extinct<- as.numeric(as.character(conservation_wide$Extinct))
conservation_wide$`In Recovery` <- as.numeric(as.character(conservation_wide$`In Recovery`))
conservation_wide$Migratory<- as.numeric(as.character(conservation_wide$Migratory))
conservation_wide$`No Concern`<- as.numeric(as.character(conservation_wide$`No Concern`))
conservation_wide$`Proposed Endangered`<- as.numeric(as.character(conservation_wide$`Proposed Endangered`))
conservation_wide$`Proposed Threatened`<- as.numeric(as.character(conservation_wide$`Proposed Threatened`))
conservation_wide$Resident<- as.numeric(as.character(conservation_wide$Resident))
conservation_wide$`Species of Concern`<- as.numeric(as.character(conservation_wide$`Species of Concern`))
conservation_wide$`Under Review`<- as.numeric(as.character(conservation_wide$`Under Review`))
conservation_wide$Threatened<- as.numeric(as.character(conservation_wide$Threatened))

#replace NA with 0
conservation_wide[is.na(conservation_wide)] <- 0

#join conservation data with parks data 
conservation_park_info <- left_join(conservation_wide, parks)

#data set for conservation category counts by species category
conservation_species <- species %>% group_by(Category, Conservation.Status) %>% tally()
conservation_species$Conservation.Status[which(conservation_species$Conservation.Status == "")] = "No Concern"
#make long to wide
conservation_species_wide <- conservation_species %>% spread(data=conservation_species, key=Conservation.Status, value=n)
#set empty to NA
conservation_species_wide$Breeder <- as.numeric(as.character(conservation_species_wide$Breeder))
conservation_species_wide$Endangered <- as.numeric(as.character(conservation_species_wide$Endangered))
conservation_species_wide$Extinct<- as.numeric(as.character(conservation_species_wide$Extinct))
conservation_species_wide$`In Recovery` <- as.numeric(as.character(conservation_species_wide$`In Recovery`))
conservation_species_wide$Migratory<- as.numeric(as.character(conservation_species_wide$Migratory))
conservation_species_wide$`No Concern`<- as.numeric(as.character(conservation_species_wide$`No Concern`))
conservation_species_wide$`Proposed Endangered`<- as.numeric(as.character(conservation_species_wide$`Proposed Endangered`))
conservation_species_wide$`Proposed Threatened`<- as.numeric(as.character(conservation_species_wide$`Proposed Threatened`))
conservation_species_wide$Resident<- as.numeric(as.character(conservation_species_wide$Resident))
conservation_species_wide$`Species of Concern`<- as.numeric(as.character(conservation_species_wide$`Species of Concern`))
conservation_species_wide$`Under Review`<- as.numeric(as.character(conservation_species_wide$`Under Review`))
conservation_species_wide$Threatened<- as.numeric(as.character(conservation_species_wide$Threatened))
#set NA to 0
conservation_species_wide[is.na(conservation_species_wide)] <- 0



write_csv(counts_area_sl, "derived_data/counts_area_sl.csv")
write_csv(conservation_park_info, "derived_data/conservation_park_info.csv")
