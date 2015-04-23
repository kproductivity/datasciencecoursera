library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

training.df <- subset(segmentationOriginal, Case == "Train")
test.df <- subset(segmentationOriginal, Case == "Test")

set.seed(125)

fit <- train(Class~., method="rpart", data=training.df)
print(fit$finalModel)

plot(fit$finalModel, uniform=TRUE)
text(fit$finalModel, use.n=TRUE, all=TRUE, cex=0.7)

newdata <- test.df
predict(fit, newdata)

############################

library(pgmm)
data(olive)
olive = olive[,-1]

fit <- train(Area~., method="rpart", data=olive)
print(fit$finalModel)

plot(fit$finalModel, uniform=TRUE)
text(fit$finalModel, use.n=TRUE, all=TRUE, cex=0.7)


newdata = as.data.frame(t(colMeans(olive)))
predict(fit, newdata)

############################

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
fit <- glm(chd ~ age+alcohol+obesity+tobacco+typea+ldl, data=trainSA,family="binomial")

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(trainSA$chd, predict(fit, trainSA, type=c("response")))
missClass(testSA$chd, predict(fit, testSA, type=c("response")))

##################

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y<-as.factor(vowel.train$y)
vowel.test$y<-as.factor(vowel.test$y)

set.seed(33833)
fit <- train(y~., method="rf", data=vowel.train)
varImp(fit)
