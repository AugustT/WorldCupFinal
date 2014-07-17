rm(list=ls())

load('AllTweets.rdata')

library(rgdal)
library(plotKML)

# get location tweets
locTweets <- tot[!is.na(tot$latitude),]

locTweets[,'longitude'] <- as.numeric(locTweets[,'longitude'])
locTweets[,'latitude'] <- as.numeric(locTweets[,'latitude'])

coordinates(locTweets) <- c('longitude','latitude')
proj4string(locTweets) <-  CRS("+proj=longlat +datum=WGS84")

library(spacetime)

fmd_ST <- STIDF(locTweets, locTweets$created,
                data.frame(ReportedDay=as.numeric(locTweets$created)))

kml(locTweets,
    file.name = 'graphs/worldcup.kml',
    folder.name = 'worldcup',
    points_names = 'text',
    size = 1,
    shape = 'http://maps.google.com/mapfiles/kml/paddle/wht-blank.png')