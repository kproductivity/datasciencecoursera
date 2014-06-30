############
## Part 4 ##
############

# Function that takes an outcome name and a hospital ranking returning
# a data frame with the hospital names and the abbreviated state name

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital <- data.frame(outcomes[, 2],
                         outcomes[, 7],
                         suppressWarnings(as.numeric(outcomes[, 11])),
                         suppressWarnings(as.numeric(outcomes[, 17])),
                         suppressWarnings(as.numeric(outcomes[, 23])))
  names(hospital) <- list("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  
  ## Check that outcome is valid
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if (!(is.element(outcome, outcome.list))) stop("invalid outcome")
  
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  # Very dirty solution. I am more than sure there must be something cleaner
  if (outcome == 'heart attack'){
    hospital <- hospital[order(hospital["state"],
                               hospital["heart attack"],
                               hospital["hospital"],
                               na.last = NA), ]
  }else{
    if (outcome == 'heart failure'){
      hospital <- hospital[order(hospital["state"],
                                 hospital["heart failure"],
                                 hospital["hospital"],
                                 na.last = NA), ]
    }else{
      hospital <- hospital[order(hospital["state"],
                                 hospital["pneumonia"],
                                 hospital["hospital"],
                                 na.last = NA), ]
    }
  }

  state.list <- levels(hospital$state)
  hospital.final <- data.frame()
  
  for (i in 1:length(state.list)){
  
      hospital.state <- hospital[hospital$state == state.list[i], ]
    
        if (num == 'best'){
          num <- 1
        }else{
          if (num == 'worst'){
            num <- nrow(hospital.state)
          }else{
            num <- num
          }
        }
        
        hospital.final[i, 1] <- as.character(hospital.state$hospital[num])
        hospital.final[i, 2] <- as.character(state.list[i])
  }
  
  
  names(hospital.final) <- list("hospital", "state")
  hospital.final
  
}
  