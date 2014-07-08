############
## Part 4 ##
############

# Function that takes an outcome name and a hospital ranking returning
# a data frame with the hospital names and the abbreviated state name

rankall <- function(outcome, num = "best") {
  ## Check that outcome is valid
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  myvars <- c(c(2, 7), switch(outcome,
                             "heart attack" = 11,
                             "heart failure" = 17,
                             "pneumonia" = 23))
  
  ## Read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  outcome <- outcome[myvars]
  outcome[,2] <-  as.factor(outcome[,2])
  outcome[,3] <- suppressWarnings(as.numeric(outcome[,3]))
                       
  names(outcome) <- list("hospital", "state", "rate")
    

  ## Ranks the hospitals in each State
  if (num == "worst"){
    outcome <- outcome[order(-outcome$rate, outcome$hospital, na.last = T), ] 
  }else{
    outcome <- outcome[order(outcome$rate, outcome$hospital, na.last = T), ]  # 'best' and num have same ranking
  }

  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  require(plyr)
  outcome.rank <- ddply(outcome, .(state),
                        hospital = function(x) as.character(x$hospital[num]))
  
  outcome.rank
  
}