library(caret)

# Using Random Forests
#======================
# Ensure to check the number of predictors to be used (in PreProcessing) --> Fixed number or Random choice
# NB: Takes a bit of a while with "Random Choice" of parameters

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:30))

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl)

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneLength = 15)

RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneGrid = expand.grid(.mtry=c(1:30)))
#warnings()

plot(RF_model)

RF_model$pred[order(RF_model$pred$Resample, RF_model$pred$rowIndex),]
RF_model
RF_model$finalModel
RF_model$results
RF_model$bestTune

confusionMatrix(RF_model)


