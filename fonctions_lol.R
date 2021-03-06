#############################################################################
#Fonctions LOL
#############################################################################
# Les fonctions necessite les packages :

# library(jsonlite)
# library(curl)
# library(httr)
#############################################################################
# MISE � JOUR
# Les fonctions sont en train d'�tre mise � jour
# lol.statsjoueur : n'est plus support� donc il n'y a pas de tableau de stats g�n�ralis�
# logiquement, les fonctions associ�s ne sont donc plus prise en compte (statsjoueur.clean etc...)

#############################################################################
# lol.idjoueur : renvoie l'id d'un joueur � partir de son pseudo (V3)
# lol.matchslist.ranked.easy : renvoie la liste des parties class�s � partir de l'account.id (V3)

# lol.staticdata.version : renvoie le numeros de la derniere version du site des donnees fixes

######################################################
#lol.idjoueur
######################################################
# Renvois les informations principales d'un joueur � partir de son pseudo
# Il faut renseigner le serveur : pour l'europe c'est euw1
# La key est la clef d'utilisation des api persos
# Le resultat est une liste avec 6 elements :
# "id" qui contient l'id du personnage
# "accountId" : qui contient l'id du compte (le plus important)
# "name" qui contient le pseudo du joueur
# "profileIconId" qui contient le numeros de l'icone d'invocateur
# "summonerlevel" qui contient le niveau du joueur
# "revisionDate" contient un nombre qui doit repr�senter la date
# pour r�cup�rer un �l�ment, utilisez les [[]] car la liste est nomm�e.

lol.idjoueur <- function(pseudo, serveur, key){
  
  fichier.json<-paste("https://",serveur,".api.riotgames.com/lol/summoner/v3/summoners/by-name/",pseudo,"?api_key=",key,sep="")
  liste<- fromJSON(fichier.json)
  return(liste)
  
}

#######################################################
# lol.matchslist.ranked.easy
#####################################################
# La fonction permet de r�cup�rer la liste des matchs class�s d'un joueur
# L'Api �tant embetante � utiliser avec ses param�tres optionnels, la version ici est la plus simple (easy)
# Elle renvera environ 150 parties, pour plus d'efficacit�, il faudra coder la version classique permettant de choisir les dates.
# Le resultat est une liste avec 4 �l�ments :
# "matches" : un tableau de donn�e avec le serveur, l'id des matches, les champions jou�s, la file, la saison, le timestamp, le role et la lane.
# "startIndex" : qui est la valeur de d�but de l'index (0 �tant le d�but de l'historique)
# "endIndex" : la fin de l'index (ampleur max : 100)
# "totalGames": le nombre de parties extraites.

lol.matchslist.ranked.easy <- function(account.id, serveur, key){
  
  fichier.json<-paste("https://",serveur,".api.riotgames.com/lol/match/v3/matchlists/by-account/",account.id,"?api_key=",key,sep="")
  liste<- fromJSON(fichier.json)
  return(liste)
  
}

#######################################################
# lol.matches
#####################################################
# La fonction permet de r�cup�rer les informations d'un matchs
# Je ne vais pas la d�crire l� donc bonne chance :D
# Mais teams et participants sont surement les �l�ments les plus importants � regarder

lol.matches <- function(matches.id, serveur, key){
  
  fichier.json<-paste("https://",serveur,".api.riotgames.com/lol/match/v3/matches/",matches.id,"?api_key=",key,sep="")
  liste<- fromJSON(fichier.json)
  return(liste)
  
}
  
#####################################################
#lol.staticdata.version
#####################################################
# La fonction renvoie la derniere version du site de donn�ees (images, icones...)

lol.staticdata.version<- function(server, key){
  fichier.json <-paste("https://global.api.pvp.net/api/lol/static-data/",serveur,"/v1.2/versions?api_key=",key,sep="")
  vecteur<-fromJSON(fichier.json)
  
  return(vecteur)
}

# La fonction retroune un vecteur character avec l'ensemble des numeros de versions, le [1] est la version actuelle
###################################################
#lol.staticdata.image
####################################################
# La fonction renvoie l'adresse de l'image d'un champion
# Les parametres sont : 
# champion : le nom du champion (chaine de charactere)
# type : le type d'image (splashart, loading, square)
# number : peut �tre vide, indique le numeros du skin (seulement pour splashart et loading)
# version : la version de staticdata (utiliser la fonction lol.staticdata.version)

lol.staticdata.image<- function(champion, type, number, version){
  if(type == "splashart"){resultat <- paste("http://ddragon.leagueoflegends.com/cdn/img/champion/splash/",champion,"_",number,".jpg",sep="")}
  if(type == "loading"){resultat <- paste("http://ddragon.leagueoflegends.com/cdn/img/champion/loading/",champion,"_",number,".jpg",sep="")}
  if(type == "square"){resultat <- paste("http://ddragon.leagueoflegends.com/cdn/",version,"/img/champion/",champion,".png",sep="")}
  
  return(resultat)
  }




