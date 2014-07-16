###Retrieve tweets to the account###
getTweets <- function(sinceID = NULL, query = NULL, geocode=NULL, n = NULL){

  load("twitteR_credentials") # load credentials
  if(!registerTwitterOAuth(Cred)) stop('login failed') # Check login
  if(is.null(query)) stop('query needed')
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  resp <- try(searchTwitter(query, cainfo = "cacert.pem", sinceID = sinceID, geocode=geocode,n=n), silent=TRUE)
  if(!is.null(attr(resp, 'class'))) if(attr(resp, 'class') == 'try-error') resp <- NULL
  
  if(length(resp) == 0){
    
    raw_twit <- NULL
  
  } else {
    
    raw_twit <- try(twListToDF(resp), silent = TRUE)
    
    if(class(raw_twit) == 'try-error'){
      
      raw_twit <- NULL
      
    } else {
      
      # This function isn't great at using sinceID so filter again
      if(!is.null(sinceID)) raw_twit <- raw_twit[raw_twit$id > sinceID,]
      
      # Remove retweets
      raw_twit <- raw_twit[raw_twit$isRetweet == FALSE,]
      
      attr(raw_twit, 'max_sinceID') <- max(raw_twit$id)
      
      if(nrow(raw_twit) == 0) raw_twit = NULL 
      
    }
    
  }
    
  return(raw_twit)

}