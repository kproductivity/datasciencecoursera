###########
# Quizz 1 #
###########

#Load data

myfile <- "C:/Users/fmarcoserrano/Downloads/Coursera-SwiftKey/final/en_US/en_US.blogs.txt"
en_US.blogs <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "C:/Users/fmarcoserrano/Downloads/Coursera-SwiftKey/final/en_US/en_US.news.txt"
en_US.news <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "C:/Users/fmarcoserrano/Downloads/Coursera-SwiftKey/final/en_US/en_US.twitter.txt"
en_US.twitter <- scan(file=myfile, what="character", sep="\n", quote="")

rm(myfile)

#Q1
#Do ls -alh in the Coursera-Swiftkey/final/en_US directory.

#Q2
#Do wc -l en_US.twitter.txt at the prompt (or git bash on windows) or length(readLines("en_US.twitter.txt")) in R

#Q3
max(nchar(en_US.blogs))
max(nchar(en_US.news))
max(nchar(en_US.twitter))

#Alternatively, a simple wc command suffices wc -L *.txt inthe directory with the three files. Note, we had a small discrepancy between doing thin in R versus WC.

#Q4
love.tweets <- sum(grepl("love", en_US.twitter, fixed=TRUE)==TRUE)
hate.tweets <- sum(grepl("hate", en_US.twitter, fixed=TRUE)==TRUE)
love.tweets/hate.tweets
rm(love.tweets, hate.tweets)

#Q5
en_US.twitter[grepl("biostats", en_US.twitter, fixed=TRUE)]

#Alternatively, grep -i "biostat" en_US.twitter.txt (note the -i doesn't matter since there's only one line ignoring case).

#Q6
tweet <- "A computer once beat me at chess, but it was no match for me at kickboxing"
sum(grepl(tweet, en_US.twitter, fixed=TRUE)==TRUE)
rm(tweet)


###########
# Quizz 2 #
###########

