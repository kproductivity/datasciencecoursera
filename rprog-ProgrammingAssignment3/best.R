############
## Part 2 ##
############

# Function that takes the 2-character abbreviated name of the state and an
# outcome name as arguments and returns the name of the hospital with the
# lowest 30-day mortality rate for that outcome

best <- function(State, outcome){
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital <- data.frame(outcomes[, 2], outcomes[, 7],
                         suppressWarnings(as.numeric(outcomes[, 11])),
                         suppressWarnings(as.numeric(outcomes[, 17])),
                         suppressWarnings(as.numeric(outcomes[, 23])))
  names(hospital) <- list("name", "state", "heart attack", "heart failure", "pneumonia")
  
  ## Check that both arguments have been included
  if (missing(State)) stop("State is missing")
  if (missing(outcome)) stop("outcome is missing")
  
  ## Check that state and outcome are valid
  data(state)
  state.list <- state.abb
  if (!(is.element(State, state.list))) stop("invalid state")
  
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death rate
  hospital.state <- hospital[ which(hospital$state==State), ]
  hospital.state <- hospital.state[order(hospital.state[outcome], na.last=NA), ]
  
  # Returns the name of the first hospital in the list, which is the one with minimum value
  as.character(hospital.state$name[1])
  
}