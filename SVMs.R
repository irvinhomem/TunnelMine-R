library(caret)
library(kernlab)
library(e1071)
library(LiblineaR)

#------------------
# Using SVMs - Support Vector Machines
#==================

svm_model <- train(frmla, data=json_features_all_pcaps_df, method = "svmRadial", trControl=train_ctrl)
#svm.model <- train(frmla, data=json_features_all_pcaps_df, method = "svmRadial", metric="ROC", trControl=train_ctrl) # Results in errors

svm.model <- train(frmla, data=json_features_all_pcaps_df, method = "svmLinear", trControl=train_ctrl) # Best results also
#svm.model <- train(frmla, data=json_features_all_pcaps_df, method = "lssvmLinear", trControl=train_ctrl) # Takes long ... results in some errors
svm_model <- train(frmla, data=json_features_all_pcaps_df, method = "svmLinear2", trControl=train_ctrl) # Best So Far for SVMs

svm_model <- train(frmla, data=json_features_all_pcaps_df, method = "svmPoly", trControl=train_ctrl)



# Results
plot(svm.model)

svm_model$pred[order(svm_model$pred$Resample, svm_model$pred$rowIndex),]
svm_model
svm_model$finalModel
svm_model$results
svm_model$bestTune

caret::confusionMatrix(svm_model)
caret::confusionMatrix(data=svm_model$pred$pred, reference = svm_model$pred$obs)
#confusionMatrix(svm_model$pred[order(svm_model$pred$Resample, svm_model$pred$rowIndex),])
