################################################
##  Partition the dataset into k-folds i.e. 10-folds in this case
################################################
library("caret")
library("rpart")

# Choosing the number of features to use in the different classifiers
#frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len + avg_dns_req_len)     # With 3 features
#frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len)                       # With 2 features
#frmla = as.formula(proto_label ~ avg_entropy)                                        # With 1 feature
frmla = as.formula(proto_label ~ .)                                                  # Randomly picked features ?? (For Random Forests)

# Setting up PRE-DEFINED (FIXED) folds/resamples --> in this case where k=10 folds (for testing) and the amount of data used for training (p = 0.9) i.e 90%
#myFolds <- createDataPartition(json_features_all_pcaps_df$avg_entropy, times = 10, p = 0.9, list = TRUE)    # The class probability and distribution got skewed here
myFolds <- createDataPartition(json_features_all_pcaps_df$proto_label, times = 10, p = 0.9, list = TRUE)   # The class probability distributions in the folds were better here
#myFolds
head(myFolds)


# Best so far, but *results in different folds* every time a new classification algorithm is tried (i.e. decision trees, knn, etc)
#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"

# Using predefined folds/resamples and Setting the parameters for the cross-validation / evaluation of the training model
# Using "k-fold Cross-Validation" where the k-folds are SET UP PREVIOUSLY and *FIXED*
train_ctrl <- trainControl(method = "cv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"

# Using Leave-One-Out-Cross-Validation (LOOCV)
#train_ctrl <- trainControl(method = "loocv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE)

