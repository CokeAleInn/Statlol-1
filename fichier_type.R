#############################
#Programme type
###########################
#
#
#
#
###########################
# Donn�es utilisateurs
##########################
#
#
#
############################

pseudo <- "Kazeel"
serveur <- "euw1"
saison <- 2016
key    <- "RGAPI-6821158c-1c77-4553-be1c-26e7c54aff6f"

##########################
# Fonctions
#########################
#
#
#############################
dir <- "C:/Documents/GitHub/Statlol"
chemin<- file.path(dir,"fonctions_lol.R")
source(file = chemin)
require(jsonlite)
require(curl)
require(httr)
require(TriMatch)

#####################################
#Algrotihme
####################################
#
#
#####################################

#r�cup�rer l'ID
result.id<-  lol.idjoueur(pseudo, serveur, key)
account.id<-result.id[[2]]

#R�cup�rer la liste des matchs class�s d'un joueur
result.matchslist <- lol.matchslist.ranked.easy(account.id, serveur, key)
matchs.list <- result.matchslist[[1]]
matchs.id.test <- matchs.list[1,2]

#R�cup�rer les informations principales d'un matchs
result.matches <- lol.matches(matchs.id.test, serveur, key)
teams.data.test <- result.matches[[11]]
participants.data.test <- result.matches[[12]]
participants.id.data.test <- result.matches[["participantIdentities"]]
test.merge <- merge(participants.data.test, participants.id.data.test)#RechercheV

#Test Adresse des images et version

version<-lol.staticdata.version(server,key)[1]
square<-lol.staticdata.image("Urgot","square",0,version)
loading<-lol.staticdata.image("Urgot","loading",1,version)
