## Main Process
rm(list=ls())

# Load libraries
library(twitteR)
library(RCurl)

# Load scripts
files <- list.files(path='Scripts/')

# Read scripts
for(i in files) source(file.path('Scripts/',i))

# Get SinceID to NULL
sinceID <- NULL

# Load credentials
load("twitteR_credentials") # load credentials - an object called 'Cred'
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
registerTwitterOAuth(Cred)

count <- 0
a <- TRUE

while(a){
  
  time <- system.time({    
  for(i in c('#WorldCup', '#GERvsARG', '#GERARG', 'world cup', 'germany', 'argentina')){

    # Set temp sinceID
    sinceIDtemp <- NULL
    
    # Read tweets
    tweets <- getTweets(query = i, sinceID = sinceID, n = 500)
    sinceIDtemp <- c(sinceIDtemp, attr(tweets, 'max_sinceID'))
        
    # Write tweets to rdata files
    save(tweets, file = paste('data/tweets_', i, '_', count, '.rdata', sep = ''))
  
    # Print progress
    print(paste(Sys.time(), i, '-', nrow(tweets)))
        
  }
  })
  
  count <- count + 1
  sinceID <- max(sinceIDtemp)
  
  # Sleep if we are going to fast
  if(time['elapsed'] < 40){
    
    print(paste('Sleeping for', 40 - time['elapsed'], 'seconds'))
    Sys.sleep(40 - time['elapsed'])
  
  }
}

# summerise
source('summerise.r')