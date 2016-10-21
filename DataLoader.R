library("rjson")

# Testing scripts in R
dirname(getwd())

concat_str = paste("string 1", "string 2", sep="/")

# paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")
dataset_path = paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")

# paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
http_ov_dns_path = paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
ftp_ov_dns_path = paste(dataset_path, "FTPovDNS-DL/All", sep="/")
http_s_ov_dns_path = paste(dataset_path, "HTTP-S-ovDNS-Static/All", sep="/")
pop3_ov_dns_path = paste(dataset_path, "POP3ovDNS-DL-5txt-ATT/All", sep="/")

# Get all files in "HTTPovDNS-Static" directory
http_ov_dns_files <- list.files(path=http_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
ftp_ov_dns_files <- list.files(path=ftp_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
http_s_ov_dns_files <- list.files(path=http_s_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
pop3_ov_dns_files <- list.files(path=pop3_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )

# Test collection of JSON data from a single file
json_data_single <- fromJSON(file=http_ov_dns_files[1])

# Convert json to data frame (may fail due to differing lengths of rows)
#json_single_data_frame <- as.data.frame(json_data_single)

typeof(json_data_single)

# Get values if a particular parameter from the json
json_data_single[[1]]
json_data_single$filename
typeof(json_data_single$filename)

json_data_single[[2]]
json_data_single$`pcap-Md5-hash`

json_data_single[[4]]
json_data_single$protocol

# Get list-item containing the 1st json property name -> DNS-Req-Lens
json_data_single[[3]][[1]]$feature_name
json_data_single$props[[1]]$feature_name

# Get list-item containing the 2nd json property name -> IP-Req-Lens
json_data_single[[3]][[2]]$feature_name
json_data_single$props[[2]]$feature_name

# Get list-item containing the 4th json property name -> DNS-Req-Qnames-Enc-Comp-Entropy
json_data_single[[3]][[4]]$feature_name
json_data_single$props[[4]]$feature_name

# Get average of entropy values for single pcap_json_object
entropy_avg = mean(json_data_single$props[[4]]$values)

# Get average IP-Req-Len for single pcap_json_object
ip_len_avg =  mean(json_data_single$props[[2]]$values)

f_name = vector()
proto_name = vector()
avg_entropy= vector()
avg_ip_req_len = vector()
avg_dns_req_len = vector()

###############################
# REPEATING CODE
###############################
# Extract features from all HTTPovDNS-Static json files in directory
for(i in 1:length(http_ov_dns_files)){
  json_file_data <- fromJSON(file=http_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

http_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(ftp_ov_dns_files)){
  json_file_data <- fromJSON(file=ftp_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

ftp_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(http_s_ov_dns_files)){
  json_file_data <- fromJSON(file=http_s_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

http_s_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(pop3_ov_dns_files)){
  json_file_data <- fromJSON(file=pop3_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

pop3_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

typeof(f_name)

# Merge multiple using "rbind" function (All column names must be the same)
json_features_all_pcaps_df <- rbind(http_ov_dns_pcap_features_df, ftp_ov_dns_pcap_features_df, http_s_ov_dns_pcap_features_df, pop3_ov_dns_pcap_features_df)

#print(pcap_features_df)
print(http_ov_dns_pcap_features_df)
print(ftp_ov_dns_pcap_features_df)
print(http_s_ov_dns_pcap_features_df)
print(pop3_ov_dns_pcap_features_df)

print(json_features_all_pcaps_df)
#str(pcap_features_df)