install.packages("devtools")

library(devtools)

install_github("mjarsma/TwitterR")

install.packages('twitteR')
library('twitteR')

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "http://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
consumerKey <- "12345pqrst6789ABCD"
consumerSecret <- "abcd1234EFGH5678ijkl0987MNOP6543qrst21"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake()
registerTwitterOAuth(twitCred)

# user The Twitter user to detail, can be character or an user object.
# n = Number of tweets to retrieve, up to a maximum of 3200
# maxID = Maximum ID to search for
# sinceID = Minimum (not inclusive) ID to search for
# includeRts = If FALSE any native retweets (not old style RT retweets) will be stripped from the results

userTimeline("newsycombinator", n=20, maxID=NULL, sinceID=NULL, includeRts=FALSE)

getTrends(period="weekly")