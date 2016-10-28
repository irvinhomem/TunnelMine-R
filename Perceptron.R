library(caret)
library(RSNNS) # This library causes problems with the "confusionMatrix" function by overshadowing the Caret one

#---------------
# Using Perceptrons
#===============

# Multilayer Perceptron
perceptron.model <- train(frmla, data=json_features_all_pcaps_df, method = "mlp", trControl=train_ctrl)


# Results
plot(perceptron.model)

perceptron.model$pred[order(perceptron.model$pred$Resample, perceptron.model$pred$rowIndex),]
perceptron.model
perceptron.model$finalModel
perceptron.model$results
perceptron.model$bestTune

caret::confusionMatrix(perceptron.model)
