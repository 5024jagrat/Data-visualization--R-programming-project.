
getwd()


setwd("D:/project")


data <- read.csv("Airline passenger satisfaction train latest.csv", header = TRUE)

head(data)
summary(data)
data$Gender <- factor(data$Gender)
data$Class <- factor(data$Class)
data$satisfaction <- factor(data$satisfaction)
#split data 
set.seed(123)
library(caTools)
split <- sample.split(data$satisfaction, SplitRatio = 0.7)
train_data <- subset(data, split == TRUE)
test_data <- subset(data, split == FALSE)
#choose the train model
library(randomForest)
model <- randomForest(satisfaction ~ ., data = train_data, ntree = 100)
#evaluate model performance
predictions <- predict(model, test_data)
table(predictions, test_data$satisfaction)
#how ur model is making decisions
#varImp(model)
table(predictions, test_data$satisfaction)
confusion <- table(predictions, test_data$satisfaction)

# Calculate accuracy
accuracy <- sum(diag(confusion)) / sum(confusion)
accuracy






