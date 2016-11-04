library(ggplot2)
library(car)

avg_entropy_vals <- json_features_all_pcaps_df$avg_entropy
avg_ip_req_lens <- json_features_all_pcaps_df$avg_ip_req_len
avg_dns_req_lens <- json_features_all_pcaps_df$avg_dns_req_len
proto_class_lbl <- json_features_all_pcaps_df$proto_label


# Using the R internal plotting function
plot(http_ov_dns_pcap_features_df$avg_ip_req_len, http_ov_dns_pcap_features_df$avg_entropy, col=http_ov_dns_pcap_features_df$proto_label)

plot(avg_entropy_vals, col = proto_class_lbl)

plot(x = ip_req_lens, y = avg_entropy_vals, col=proto_class_lbl, pch = 20,
     xlab = "IP Req Len", ylab = "Avg. Qname Entropy")
legend(x="bottomleft", legend = levels(proto_class_lbl), col = seq_along(levels(proto_class_lbl)), pch=20)

#plot(x = ip_req_lens, y = avg_entropy_vals, col=proto_class_lbl, pch = 1,
#     xlab = "IP Req Len", ylab = "Avg. Qname Entropy")
#legend(x="bottomleft", legend = levels(proto_class_lbl), pch=1)

#plot(x = ip_req_lens, y = avg_entropy_vals, col=proto_class_lbl, pch = c(1,2,3,4),
#     xlab = "IP Req Len", ylab = "Avg. Qname Entropy")
#legend(x="bottomleft", legend = levels(proto_class_lbl), pch=c(1,2,3,4))

#plot(x = ip_req_lens, y = avg_entropy_vals, col=proto_class_lbl, pch = 4,
#     xlab = "IP Req Len", ylab = "Avg. Qname Entropy")
#legend(x="bottomleft", legend = levels(proto_class_lbl), pch=c(4,4))
#legend(x="bottomleft", legend = levels(proto_class_lbl), pch=c(2,2))
#legend(x="bottomleft", legend = levels(proto_class_lbl), pch=c(2,2))
#legend(x="topright", legend = levels(proto_class_lbl), pch=1)

plot(x = dns_req_lens, y = avg_entropy_vals, col=proto_class_lbl,
     xlab = "DNS Req Length", ylab = "Avg. Entropy")
abline(lm(avg_dns_req_lens ~ avg_entropy_vals), col = "cyan")

# Using ggplot2
# Plotting Entropy with bins (default binwidth = 30 ??)
qplot(
  x = json_features_all_pcaps_df$avg_entropy,
  data = json_features_all_pcaps_df,
  color = json_features_all_pcaps_df$proto_label
)

# Plotting Entropy against ip Req Length
qplot(
  x = json_features_all_pcaps_df$avg_entropy,
  y = json_features_all_pcaps_df$avg_ip_req_len,
  data = json_features_all_pcaps_df,
  color = json_features_all_pcaps_df$proto_label
)

# Plotting Entropy against DNS Req Length
qplot(
  x = json_features_all_pcaps_df$avg_entropy,
  y = json_features_all_pcaps_df$avg_dns_req_len,
  data = json_features_all_pcaps_df,
  color = json_features_all_pcaps_df$proto_label
)
