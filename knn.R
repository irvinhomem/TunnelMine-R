
#======
# k-NN (k-Nearest Neighbours)
#======
# "preProcess" in order to normalize with "center" and "scale" (something like z-score-normalization)
# “center“: subtract mean from values.
# “scale“: divide values by standard deviation.
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneLength = 10)
# 1-30 NN
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:30))
# only 1-NN
knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1)) #1-NN

plot(knnFit)
knnFit
knnFit$finalModel
knnFit$results
knnFit$bestTune
knnFit$pred[order(knnFit$pred$Resample, knnFit$pred$rowIndex),]
confusionMatrix(knnFit)


