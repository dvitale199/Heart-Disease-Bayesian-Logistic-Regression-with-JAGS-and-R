# the following provides preprocessing and EDA for heard disease data
library(ggplot2)
library(purrr)
library(tidyr)


myData <- read.csv("data/heart.csv")

#dimensions of myData
dim(myData)

# check NAs-- None
table(is.na(myData))

# get summary of data and examine each variable
summary(myData)

# plot histogram for each feature
# histogram plotting taken from: https://drsimonj.svbtle.com/quick-plot-of-all-variables
myData %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +
  geom_histogram()

# now scale age, chol, oldpeak, thalach, trestbps for logistic regression
scaleData <- myData
scaleData[c("age", "ca", "chol", "cp", "oldpeak", "restecg", "slope", "thal", "thalach", "trestbps")] <- lapply(myData[c("age", "ca", "chol", "cp", "oldpeak", "restecg", "slope", "thal", "thalach", "trestbps")], function(x) c(scale(x)))

#change non-numeric to factors
scaleData[!names(scaleData) %in% c("age", "ca", "chol", "cp", "oldpeak", "restecg", "slope", "thal", "thalach", "trestbps")] <- as.factor(unlist(scaleData[,!names(scaleData) %in% c("age", "ca", "chol", "cp", "oldpeak", "restecg", "slope", "thal", "thalach", "trestbps")]))

# check out scaled data
# histogram plotting taken from: https://drsimonj.svbtle.com/quick-plot-of-all-variables
scaleData %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +
  geom_histogram()

# check for and remove outliers
rm_outliers <- function(df, column) {
  outliers <- boxplot(df[,column], plot=FALSE)$out
  new_df <- df[-which(df[,column] %in% outliers),]
  return(new_df)
}

test_outliers_list <- c("chol","oldpeak","thalach","trestbps")

cleanData <- scaleData

for (var in test_outliers_list) {
  cleanData <- rm_outliers(cleanData, var)
}

write.csv(cleanData, file = "cleanData.csv", row.names = FALSE, quote = FALSE)


# percentage of males with heart disease
nrow(myData[myData$sex == 1 & myData$target == 1,])/nrow(myData[myData$sex == 1,])*100
# percentage of females with heart disease
nrow(myData[myData$sex == 0 & myData$target == 1,])/nrow(myData[myData$sex == 0,])*100

# examining cholesterol and target
boxplot(myData$chol, main="Cholesterol")

# cholesterol with heart disease
hd = myData[myData$target ==1,]
boxplot(hd$chol, main="Cholesterol- (+) Heart Disease")
mean(hd$chol)

# cholesterol without heart disease
nhd = myData[myData$target ==0,]
boxplot(nhd$chol, main="Cholesterol- (-) Heart Disease")
mean(nhd$chol)



