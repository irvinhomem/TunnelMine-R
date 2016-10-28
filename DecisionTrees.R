library(caret)
#======
#  Decision Trees
#======
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", cp=0.2405063, trControl = train_ctrl)
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", cp = 0.002, trControl = train_ctrl)
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", trControl = train_ctrl)   # 'rpart' with 2 features, HTTP-S is missing
tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart2", trControl = train_ctrl)  # 'rpart2' with 2 features does better classificaiton

#########################
##  Decision Tree results
#########################
print(tree_model)
plot(tree_model)
summary(tree_model)

# Normal tree plots
plot(tree_model$finalModel)
text(tree_model$finalModel)

# Extra info
# Training Data
#print(tree_model$trainingData)   # <-- Works, but shows all the data used in totality

# Resampling parameters
#print(tree_model$resample)
tree_model$resample

# Predictions and Observations from the k-fold cross validation
#print(tree_model$pred)     # <-- Works but shows all the samples with different "cp" values (Complexity parameter) 
#### Fixed after setting the "savePredictions" and the "returnSamp" to "final" to save only the final predictions (corrects the error above and below)
tree_model$pred[order(tree_model$pred$Resample, tree_model$pred$rowIndex),]            # <-- Works but shows all the samples with different "cp" values (Complexity parameter)
tree_model$results
tree_model$bestTune
tree_model$finalModel$splits

tree_model$method
#print(tree_model$modelInfo)

# Confusion Matrix
print("Confusion Matrices for training model")
caret::confusionMatrix(tree_model)
caret::confusionMatrix(data=tree_model$pred$pred, reference = tree_model$pred$obs)

# Fancy Plot from "rattle" package
library("rattle")
library(rpart.plot)
fancyRpartPlot(tree_model$finalModel)
rattle()

#library("ggplot2")
#library(ggdendro)
#ggplot(tree_model)

#d_data <- dendro_data(tree_model$finalModel)
#ggdendrogram(d_data)

#ggplot() + 
#  geom_segment(data = d_data$segments, 
#               aes(x = x, y = y, xend = xend, yend = yend)) + 
#  geom_text(data = d_data$labels, 
#            aes(x = x, y = y, label = label), size = 3, vjust = 0) +
#  geom_text(data = d_data$leaf_labels, 
#            aes(x = x, y = y, label = label), size = 3, vjust = 1) +
#  theme_dendro()
