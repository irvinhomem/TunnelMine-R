library(caret)

#======
# k-NN (k-Nearest Neighbours)
#======
# "preProcess" in order to normalize with "center" and "scale" (something like z-score-normalization)
# “center“: subtract mean from values.
# “scale“: divide values by standard deviation.
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneLength = 5)
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneLength = 10)
# 1-30 NN
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:30))
# 1-20 NN
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:20))
# only 1-NN
knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=5)) #1-NN
# only 1-7-NN
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:7))
# only Odd from 1-13-NN
knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=c(1,3,5,7,9,11,13)))


plot(knnFit)

knnFit$pred[order(knnFit$pred$Resample, knnFit$pred$rowIndex),]
knnFit
knnFit$finalModel
knnFit$results
knnFit$bestTune

posPredValue(knnFit$pred$pred, knnFit$pred$Resample)

caret::confusionMatrix(knnFit)
caret::confusionMatrix(data=knnFit$pred$pred, reference = knnFit$pred$obs)


