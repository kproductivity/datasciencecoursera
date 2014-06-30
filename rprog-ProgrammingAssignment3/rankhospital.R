############
## Part 3 ##
############

# Function that takes the 2-character abbreviated name of the state, and
# outcome name, and a ranking position as arguments and returns the name
# of the hospital


rankhospital <- function(State, outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital <- data.frame(outcomes[, 2],
                         outcomes[, 7],
                         suppressWarnings(as.numeric(outcomes[, 11])),
                         suppressWarnings(as.numeric(outcomes[, 17])),
                         suppressWarnings(as.numeric(outcomes[, 23])))
  names(hospital) <- list("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  
  ## Check that state and outcome are valid
  data(state)
  state.list <- state.abb
  if (!(is.element(State, state.list))) stop("invalid state")
  
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  
  ## Return hospital name in that state with the given rank ## 30-day death rate
  hospital.state <- hospital[ which(hospital$state==State), ]
  hospital.state <- hospital.state[order(hospital.state[outcome],
                                         hospital.state["hospital"],
                                         na.last=NA), ]
  
  
  # Returns the name of the first hospital in the list, which is the one with minimum value
  worst.hospital <- as.numeric(nrow(hospital.state))
  
  if (!is.numeric(num)){ #translates 'best' and 'worst'
      num <- switch(num,
                    'best' = 1,
                    'worst' = worst.hospital)
  }
  
  if (num > worst.hospital){
    NA
  }else{
    as.character(hospital.state$hospital[num])
  }
}
