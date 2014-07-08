complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
		
		files <- dir(directory, full.names=TRUE)
		
		dataset <- data.frame()
		compl <- data.frame()
		
		for (i in id){
			dataset <- rbind(dataset, read.csv(files[i], header = TRUE, sep = ","))
			nobs <- sum(complete.cases(read.csv(files[i], header = TRUE, sep = ",")))
			compl <- rbind(compl, c(i, nobs))
		}
		
		colnames(compl) <- c("id", "nobs")
		compl
		
}