library(randomForest)


set.seed(123)
input_data <- read.csv("data/csvfortrain/df_jieba768.csv")
input_data <- input_data[, -1]

#建立随机森林模型
random_forest_model <- randomForest(dim1 ~ ., 
                         data=input_data, 
                         mtry=28,
                         importance=TRUE, 
                         proximity=TRUE,
                         na.action=na.omit)

random_forest_model
plot(random_forest_model)
importance(random_forest_model)
varImpPlot(random_forest_model)

feature_importance <- importance(random_forest_model)
str(feature_importance)

positive_importance <- feature_importance[feature_importance[, "%IncMSE"] > 0, ]
positive_importance <- cbind(feature = rownames(positive_importance), positive_importance)
write.csv(positive_importance, file = "positive_importance.csv", row.names = FALSE)


