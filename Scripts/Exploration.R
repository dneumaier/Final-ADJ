library(tidyverse) #bringing in tidyverse

data <- read_csv("Data/2021_LoL_esports_match_data_from_OraclesElixir_20211004.csv")
#calling the data data

#A definitions page is available here: https://oracleselixir.com/definitions
#All relevant, included tournaments are here: https://oracleselixir.com/stats/players/byTournament, EM = EUM

data %>% group_by(gameid) %>% count()

#grouping the data to verify what they are, 12 on each is correct (1 for each player and 1 for team 2 teams + 10 players=12 instances)

data %>% group_by(gameid) %>% count() %>% arrange(desc(n()))
#verified by flipping the arrange that all are 12 (and no NAs for game count)

data %>% group_by(datacompleteness) %>% count()

#checking what values appear under datacompleteness


NACompletes <- data %>% filter(is.na(datacompleteness))
#just wanted to see what some of the NAs were, some of this might still be usable, but I might just focus on what follows

#This is likely what I will focus on using
CompleteData <- data %>% filter(datacompleteness == "complete")
#This represents 93,648/133,428 rows or about 61% of the data is complete, another 9% is partial (not shown)

#filtering for games to find the max number of turret plates, removed desc to check for lowest
data %>% group_by(gameid) %>% filter(!is.na(turretplates)) %>% select(gameid, datacompleteness, turretplates) %>% arrange(desc(turretplates))
#0-15 is max as seen in game. Only outer turrets have plates, there are 3 outer turrets with 5 plates each so 
#15 plates is a major early lead, only happened 3 times

#Curious as to which regions those three games were.
CompleteData %>% group_by(gameid) %>% filter((playerid == "100" | playerid == "200") & (gameid == "ESPORTSTMNT03_2074070" | gameid == "ESPORTSTMNT06_1881146" | gameid == "ESPORTSTMNT02_2151778")) %>%
  select(gameid, league, date, turretplates)
#Another way to do this would be to filter not for playerid being a team but for turretplates equaling 15
#The three leagues where absolute dominance occurred were HM (Hitpoint Masters) EM (EU Masters) and LCSA (League Championship Series Academy)


