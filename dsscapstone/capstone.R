###########
# Quizz 1 #
###########

#Load data

myfile <- "C:/Dropbox/Coursera-SwiftKey/final/en_US/en_US.blogs.txt"
en_US.blogs <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "C:/Dropbox/Coursera-SwiftKey/final/en_US/en_US.news.txt"
en_US.news <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "C:/Dropbox/Coursera-SwiftKey/final/en_US/en_US.twitter.txt"
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
corp.source <- paste(en_US.blogs,en_US.news,en_US.twitter)
my.source <- VectorSource(corp.source)
corpus <- VCorpus(my.source)

rm(corp.source, my.source)
summary(corpus)

#Get the 'dirty' term matrix
dtm <- DocumentTermMatrix(corpus)
dim(dtm)
#wordcount
rowSums(as.matrix(dtm))

count<- as.data.frame(inspect(dtm))
count$word = rownames(count)
colnames(count) <- c(“count”,”word” )
count <- count[order(count$count, decreasing=TRUE), ]

#Clean corpus; use getTransformations() to see all available.
##every word to lower case
corpus <- tm_map(corpus, content_transformer(tolower))
##remove numbers
corpus <- tm_map(corpus, removeNumbers)
##strip whitespaces
corpus <- tm_map(corpus, stripWhitespace)
##we could remove stopwords, but we need them for predictive purposes
##corpus <- tm_map(corpus, removeWords, stopwords("english"))

##we could remove our own stop words.
##Profanity list from http://www.cs.cmu.edu/~biglou/resources/
url <- "http://www.cs.cmu.edu/~biglou/resources/bad-words.txt"
profanity <- read.csv(url, header=FALSE)
ownStopWords <- as.character(profanity[[1]])
corpus <- tm_map(corpus, removeWords, ownStopWords)

rm(url, profanity, ownStopWords)

inspect(corpus)

##General transforming functions

###to white space
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "/|@|\\|")

###to something else
toString <- content_transformer(function(x, from, to) gsub(from, to, x))
corpus <- tm_map(corpus, toString, "harbin institute technology", "HIT")

rm(toSpace, toString)

#Write corpus into a directory
writeCorpus(corpus)


#Get the cleaned term matrix
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


#Plot frequencies
term.freq <- rowSums(as.matrix(tdm))
term.freq <- subset(term.freq, term.freq >= 15)
df <- data.frame(term = names(term.freq), freq = term.freq)
library(ggplot2)
ggplot(df, aes(x = term, y = freq)) + geom_bar(stat = "identity") +
    xlab("Terms") + ylab("Count") + coord_flip()

#And associations
library(graph)
library(Rgraphviz)
plot(tdm, term = freq.terms, corThreshold = 0.1, weighting = T)

##########
# Task 4 #
##########

library(tm)

#Load data
myfile <- "./final/en_US/en_US.blogs.txt"
en_US.blogs <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "./final/en_US/en_US.news.txt"
en_US.news <- scan(file=myfile, what="character", sep="\n", quote="")

myfile <- "./final/en_US/en_US.twitter.txt"
en_US.twitter <- scan(file=myfile, what="character", sep="\n", quote="")

rm(myfile)

#Select a sample of 1% of the total documents
blogs <- sample(en_US.blogs, size = ceiling(length(en_US.blogs)/100),
                replace = FALSE)
news <- sample(en_US.news, size = ceiling(length(en_US.news)/100),
               replace = FALSE)
twitter <- sample(en_US.twitter, size = ceiling(length(en_US.twitter)/100),
                  replace = FALSE)

rm(en_US.blogs, en_US.news, en_US.twitter)

#Generate corpus (text that will be used to build algorithm)
corp.source <- VectorSource(paste(blogs, news, twitter))
rm(blogs, news, twitter)

corpus <- VCorpus(corp.source, readerControl = list(language = "English"))
rm(corp.source)

#Clean corpus

url <- "http://www.cs.cmu.edu/~biglou/resources/bad-words.txt"
profanity <- read.csv(url, header=FALSE)
ownStopWords <- as.character(profanity[[1]])

CleanCorpus <- function(x){
    #corpus <- tm_map(corpus, removeWords, stopwords("english"))
    x <- tm_map(x, removeWords, ownStopWords)
    x <- tm_map(x, content_transformer(tolower))
    x <- tm_map(x, removeNumbers)
    x <- tm_map(x, removePunctuation)
    x <- tm_map(x, stripWhitespace)
    x <- tm_map(x, PlainTextDocument)  
    return(x)
}

CleanCorpus(corpus)

#Tokenize

## Sets the default number of threads to use
options(mc.cores=1)

OnegramTokenizer <-
    function(x)
        unlist(lapply(ngrams(words(x), 1), paste, collapse = " "),
               use.names = FALSE)

BigramTokenizer <-
    function(x)
        unlist(lapply(ngrams(words(x), 2), paste, collapse = " "),
               use.names = FALSE)

TrigramTokenizer <-
    function(x)
        unlist(lapply(ngrams(words(x), 3), paste, collapse = " "),
               use.names = FALSE)

tdm1 <- TermDocumentMatrix(corpus, control = list(tokenize = OnegramTokenizer))

tdm2 <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))

tdm3 <- TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))


# Find associations

findAssocs(tdm1, "case", corlimit = 0.25)
findAssocs(tdm2, "case of", corlimit = 0.25)
findAssocs(tdm3, "a case of", corlimit = 0.25)
