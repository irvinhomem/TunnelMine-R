################################################
##  Partition the dataset into k-folds i.e. 10-folds in this case
################################################
library("caret")
library("rpart")

#http_flds <- createFolds(http_ov_dns_pcap_features_df, k = 10, list = FALSE, times = 10)

#frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len + avg_dns_req_len)  # With 3 features
frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len)                   # With 2 features
#frmla = as.formula(proto_label ~ avg_entropy)                   # With 1 feature


#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = TRUE, returnResamp = TRUE, classProbs = TRUE) # classProbs = TRUE # sampling = "none"
#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = "final", returnResamp = TRUE, classProbs = TRUE) # classProbs = TRUE # sampling = "none"
# Best so far, but results in different folds every time a new classifcation algorithm is tried (i.e. decision trees, knn, etc)
#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"
#myFolds <- createFolds(json_features_all_pcaps_df$avg_entropy, k = 10, returnTrain = FALSE)
#myFolds <- createDataPartition(json_features_all_pcaps_df$avg_entropy, times = 10, p = 0.9, list = FALSE)
myFolds <- createDataPartition(json_features_all_pcaps_df$proto_label, times = 10, p = 0.9)
#myFolds
head(myFolds)
train_ctrl <- trainControl(method = "cv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"
#train_ctrl <- trainControl(method = "loocv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE)