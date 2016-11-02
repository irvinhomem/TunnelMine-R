library(caret)
library(nnet)

#-----------------
# Using Neural Networks
#=================

neuralnet.model <- train(frmla, data=json_features_all_pcaps_df, method = "nnet", trControl=train_ctrl)

neuralnet.model <- train(frmla, data=json_features_all_pcaps_df, method = "pcaNNet", trControl=train_ctrl) # Good results

neuralnet.model <- train(frmla, data=json_features_all_pcaps_df, method = "multinom", trControl=train_ctrl) # Best Results so far


plot(neuralnet.model)

neuralnet.model$pred[order(neuralnet.model$pred$Resample, neuralnet.model$pred$rowIndex),]
neuralnet.model
neuralnet.model$finalModel
neuralnet.model$results
neuralnet.model$bestTune

caret::confusionMatrix(neuralnet.model)
caret::confusionMatrix(data=neuralnet.model$pred$pred, reference = neuralnet.model$pred$obs)
