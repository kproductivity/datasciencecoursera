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
  
  # if (missing(State)) stop("state is missing")
  # if (missing(outcome)) stop("outcome is missing")
  
  
  ## Check that state and outcome are valid
  
  ## I consider this is a best solution for validating State.
  ## However, the package is not available for R3.1.0
  # source(state) # it assumes package state is installed
  # state.list <- state.abb()
  
  ## so, I need to build the state list myself
  state.list <- levels(hospital$state)
  
  if (!(is.element(State, state.list))) stop("invalid state")
  
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  hospital.state <- hospital[ which(hospital$state==State), ]
  
  # Dirty solution. I am sure there must be something cleaner
  if (outcome == 'heart attack'){
    hospital.state <- hospital.state[order(hospital.state["heart attack"], na.last=NA), ]
  }else{
    if (outcome == 'heart failure'){
      hospital.state <- hospital.state[order(hospital.state["heart failure"], na.last=NA), ]
    }else{
      hospital.state <- hospital.state[order(hospital.state["pneumonia"], na.last=NA), ]
    }
  } 
  
  # Returns the name of the first hospital in the list, which is the one with minimum value
  as.character(hospital.state$name[1])
  
}