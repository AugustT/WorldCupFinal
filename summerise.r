rm(list=ls())
tot <- NULL

for(file in list.files(path='data')){
    
  load(paste('data/', file, sep = ''))
  #print(paste(file, 'has', nrow(tweets), 'rows'))
  
  tot <- rbind(tot, tweets)  
  
  print(file)
}

nrowall <- nrow(tot)
nrowunique <-nrow(unique(tot))

print(paste('Together there are', nrowall, 'tweets.', nrowunique, 'are unique'))
save(tot, file = 'AllTweets.rdata')