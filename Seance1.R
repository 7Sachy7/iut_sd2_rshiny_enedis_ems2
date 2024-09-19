#Importer les données
setwd("L:/BUT/SD/Promo 2023/alucas/A. SD2/Projet R Shiny")
getwd()
log_ex=read.csv(file="dpe-v2-logements-existants.csv",sep=",",dec=".")
View(log_ex)
log_neufs=read.csv(file="dpe-v2-logements-neufs.csv",sep=",",dec=".")
View(log_neufs)

#3
dim(log_ex)
dim(log_neufs)

#4
log_ex$Logement="Ancien"
log_neufs$Logement="Neuf"

#5
log_neufs$Année_construction=2024
class(log_neufs$Année_construction)
#6
colnames(log_ex)
colnames(log_neufs)

col_communes = intersect(colnames(log_ex),colnames(log_neufs))

#Remettre à jour ancien et neuf en ne comprenant que les col_communes 
ancien = log_ex[ , col_communes]
neuf = log_neufs[ , col_communes]
dffinale=rbind(ancien,neuf)

#7
dffinale$Année_DPE=substr(dffinale$Date_réception_DPE,0,4)
dffinale$Année_DPE=as.numeric(dffinale$Année_DPE)
class(dffinale$Année_DPE)

#8
dffinale$verif= ifelse(dffinale$Coût_total_5_usages ==(dffinale$Coût_chauffage+dffinale$Coût_éclairage+
                                                      dffinale$Coût_ECS+dffinale$Coût_refroidissement+dffinale$Coût_auxiliaires),"OUIOUIOUI","AÏE")

#9
dffinale$Coût_chauffage_en_pourcent=(dffinale$Coût_chauffage/dffinale$Coût_total_5_usages*100)

#10
dffinale$Période_construction=cut(dffinale$Année_construction, breaks = c(1900,1960,1970,1980,1990,2000,2010,2024), labels = c("Avant 1960", "1961 - 1970", "1971 - 1980", "1981 - 1990", "1991 - 2000", "2001 - 2010", "Après 2010"))



