rm(list=ls())
install.packages("devtools")
install.packages('twitteR')

library(devtools)
library(twitteR)
library(ROAuth)
library(RCurl)
library(twitteR)

##############################
### Authentication
##############################
download.file(url="http://curl.haxx.se/ca/cacert.pem",
              destfile="cacert.pem")

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "WaGVOcGuVER2UVLmF36rEW23"
consumerSecret <- "EGTK7DhhfuWpu8tyNKBq477iJzadoGh0UonPTREcNWTA1C5En6"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake(cainfo="cacert.pem")

registerTwitterOAuth(twitCred)

save(list="twitCred", file="twitteR_credentials")

##############################
### Queries to Twitter
##############################

# use the cert for queries from Twitter (cainfo)
tweets = searchTwitter('@newsycombinator',n=100, cainfo="cacert.pem")

# how many tweets?
length(tweets)
# 500th tweet
tweet500 = tweets[[100]]
# show text from the 500th tweet
tweet500$getText()

# user The Twitter user to detail, can be character or an user object.
# n = Number of tweets to retrieve, up to a maximum of 3200
# maxID = Maximum ID to search for
# sinceID = Minimum (not inclusive) ID to search for
# includeRts = If FALSE any native retweets (not old style RT retweets) will be stripped from the results
userTimeline("newsycombinator", n=20, maxID=NULL, sinceID=NULL, includeRts=FALSE, cainfo="cacert.pem")

getTrends(period="weekly")

# create an empty vector to store tweets texts
texts <- vector(mode = "character", length = length(tweets))

# extract the tweet text from each tweet status
for (i in 1:length(tweets))
  texts[i] <- tweets[[i]]$getText()

# or extract the screen names
for (i in 1:length(tweets))
  texts[i] <- tweets[[i]]$getScreenName()

# list all the tweets
texts