
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(), dbname = "~/.Bio/bio.gpkg")
dbListTables(con)

Test <- dbSendQuery(con, 'select bio_type_level1, Sum(ab) from coral_reefs group by bio_type')
dbFetch(Test, n=-1)

Sum_Ab <- dbSendQuery(con, 'select Sum(ab) from coral_reefs group by bio_type')
ab_dataset <- unlist(dbFetch(Sum_Ab, n=-1))

Total_ab_Of_Hard_Corals = ab_dataset[10]
Total_ab_Of_Dead_Corals = ab_dataset[8] + ab_dataset[12]
Total_ab_Of_Algae = ab_dataset[2] + ab_dataset[4] + ab_dataset[5]
Total_ab_Of_SND = ab_dataset[14]
Total_ab_Of_Others = ab_dataset[3] + ab_dataset[6] + ab_dataset[7] + ab_dataset[9] + ab_dataset[11] + ab_dataset[13] + ab_dataset[15]

Total_ab_dataset <- c(Total_ab_Of_Hard_Corals, Total_ab_Of_Dead_Corals, Total_ab_Of_Algae, Total_ab_Of_SND, Total_ab_Of_Others)

names_of_coral_types <- c("Hard-Corals", "Dead-Corals", "Algae", "Sand", "Others" )

barplot(Total_ab_dataset, names.arg = names_of_coral_types , xlab = "coral types", ylab = "Total abundance of coral types", main = "Total abundance of coral types on Poivre in 2017"
        , border = "black", col = c("Red","Brown","Green","Beige","grey"), density = 175 ,ylim = c(0,700) )

pie(Total_ab_dataset, labels = names_of_coral_types, edges = 300, border = "black", radius = 2.25, col = c("Red","Brown","Green","Beige","grey"))

dbDisconnect(con)