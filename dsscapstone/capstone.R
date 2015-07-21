####################
# Task 0 - Quizz 1 #
####################

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
# Task 1 #
###########

library(tm)

#Generate corpus
corp.source <- en_US.news
my.source <- VectorSource(corp.source)
corpus <- VCorpus(my.source)

summary(corpus)

#Clean corpus; use getTransformations() to see all available.
##every word to lower case
corpus <- tm_map(corpus, content_transformer(tolower))
##remove numbers
corpus <- tm_map(corpus, removeNumbers)
##strip whitespaces
corpus <- tm_map(corpus, stripWhitespace)
##we could remove stopwords, but we need them for predictive purposes
##corpus <- tm_map(corpus, removeWords, stopwords(“english”))

##we could remove our own stop words.
ownStopWords <- c("")
corpus <- tm_map(corpus, removeWords, ownStopWords)


inspect(corpus)

##General transforming functions

###to white space
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "/|@|\\|")

###to something else
toString <- content_transformer(function(x, from, to) gsub(from, to, x))
corpus <- tm_map(corpus, toString, "harbin institute technology", "HIT")



#Write corpus into a directory
writeCorpus(corpus)


#Get the term matrix
dtm <- DocumentTermMatrix(corpus)
dim(dtm)

#Remove sparse items
dtm2 <- removeSparseTerms(dtm, sparse=0.95)
dim(dtm2)

#Show frequent terms
findFreqTerms(dtm2, 2)
#or, better
freq <- sort(colSums(as.matrix(dtm2)), decreasing=TRUE)
word.freq <- data.frame(word=names(freq), freq=freq)
barplot(height=word.freq$freq, names.arg=word.freq$word)


#Tokenize
##Unigrams
tokens <- MC_tokenizer(corpus)

##Ngrams
tokenizer <- function(x, size) unlist(lapply(ngrams(words(x), size),
                                             paste, collapse = " "),
                                      use.names = FALSE)
