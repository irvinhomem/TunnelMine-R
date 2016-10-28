library(caret)

# Using Random Forests
#======================
# Ensure to check the number of predictors to be used (in PreProcessing) --> Fixed number or Random choice
# NB: Takes a bit of a while with "Random Choice" of parameters

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, preProcess = c("center", "scale"))

# Most realistic
RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl)

# NB: When  tuneLength or tuneGrid have a "mtry" value greater than the number of features/columns/predictors available, Caret
# creates "dummy variables" as extra predictors/features/columns to fill up the space (which may create weird results)
# Best so far: Nice looking graph :-)
RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneLength = 15)

# mtry: Number of variables randomly sampled as candidates at each split.
# ntree: Number of trees to grow. (only in "RandomForest" package, not in Caret)
#metric_param <- "Accuracy"
#metric_param <- "ROC"
#Not so good
##RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneGrid = expand.grid(.mtry=c(1:15)))
# Better (But takes rather long if allowed to choose random features)
RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneGrid = expand.grid(.mtry=c(1:30)))

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, tuneGrid = expand.grid(.mtry=c(1:20)))

# Default ntree = 500
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=300, tuneGrid = expand.grid(.mtry=c(1:20)))
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=100, tuneGrid = expand.grid(.mtry=c(1:30)))
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=100, tuneGrid = expand.grid(.mtry=c(1:15)))
RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=300, tuneGrid = expand.grid(.mtry=c(1:3)))
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=100, tuneGrid = expand.grid(.mtry=c(1:5)))

#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=300)
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=100)
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=50)
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=10)
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=5)
#RF_model <- train(frmla, data=json_features_all_pcaps_df, method = "rf", trControl=train_ctrl, ntree=2)

warnings()

#head(RF_model$terms)
head(RF_model$trainingData)

plot(RF_model)

RF_model$pred[order(RF_model$pred$Resample, RF_model$pred$rowIndex),]
RF_model
RF_model$finalModel
RF_model$results
RF_model$bestTune

confusionMatrix(RF_model)


