############
## Part 3 ##
############

# Function that takes the 2-character abbreviated name of the state, and
# outcome name, and a ranking position as arguments and returns the name
# of the hospital


rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital <- data.frame(outcomes[, 2],
                         outcomes[, 7],
                         suppressWarnings(as.numeric(outcomes[, 11])),
                         suppressWarnings(as.numeric(outcomes[, 17])),
                         suppressWarnings(as.numeric(outcomes[, 23])))
  names(hospital) <- list("name", "state", "heart attack", "heart failure", "pneumonia")
  
  
  ## Check that state and outcome are valid
  state.list <- levels(hospital$state)
  if (!(is.element(state, state.list))) stop("invalid state")
  
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  
  ## Return hospital name in that state with the given rank ## 30-day death rate
  hospital.state <- hospital[ which(hospital$state==state), ]
  
  # Dirty solution. I am sure there must be something cleaner
  if (outcome == 'heart attack'){
    hospital.state <- hospital.state[order(hospital.state["heart attack"],
                                           hospital.state["name"],
                                           na.last=NA), ]
  }else{
    if (outcome == 'heart failure'){
      hospital.state <- hospital.state[order(hospital.state["heart failure"],
                                             hospital.state["name"],
                                             na.last=NA), ]
    }else{
      hospital.state <- hospital.state[order(hospital.state["pneumonia"],
                                             hospital.state["name"],
                                             na.last=NA), ]
    }
  } 
  
  # Returns the name of the first hospital in the list, which is the one with minimum value
  worst.hospital <- as.numeric(nrow(hospital.state))
  
  if (num == 'best'){
    as.character(hospital.state$name[1])
  }else{
    if (num == 'worst'){
      as.character(hospital.state$name[worst.hospital])
    }else{
      if (num > worst.hospital){
        NA
      }else{  
        as.character(hospital.state$name[num])
      }
    }
  }
  
}
