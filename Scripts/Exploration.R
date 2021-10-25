library(tidyverse) #bringing in tidyverse

data <- read_csv("Data/2021_LoL_esports_match_data_from_OraclesElixir_20211004.csv")
#calling the data data


data %>% group_by(gameid) %>% count()

#grouping the data to verify what they are


data %>% group_by(datacompleteness) %>% count()

#checking what values appear under datacompleteness


NACompletes <- data %>% filter(is.na(datacompleteness))
#just wanted to see what some of the NAs were 

#filtering for games to find the max number of turret plates, removed desc to check for lowest
data %>% group_by(gameid) %>% filter(!is.na(turretplates)) %>% select(gameid, datacompleteness, turretplates) %>% arrange(turretplates)
#0-15

