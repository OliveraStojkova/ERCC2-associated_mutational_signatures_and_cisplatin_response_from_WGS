# Separate treated and untreated
dbs_matrix_treated <- dbs_matrix[,grep("cis", colnames(dbs_matrix))]
dbs_matrix_untreated <- dbs_matrix[, grep("untreated", colnames(dbs_matrix))]

# Check the number of mutations per sample
colSums(dbs_matrix_treated)
colSums(dbs_matrix_untreated) --> Relatively low, might cause unreliable results --> NMF only on the treated set

dbs_matrix_treated_w_pseudocount <- dbs_matrix_treated + 0.0001

estimate_dbs_treated <- nmf(dbs_matrix_treated_w_pseudocount, rank = 2:8, method = "brunet", 
                nrun = 10, seed = 123456, .opt = "v-p")

plot(estimate_dbs_treated)

# Extract signatures
nmf_res_dbs_treated <- extract_signatures(dbs_matrix_treated_w_pseudocount, rank = 2, nrun = 10, single_core = TRUE)

# Get reference COSMIC signatures
dbs_signatures <- get_known_signatures(muttype = "dbs", genome = "GRCh38")

# Rename the signatures extracted by NMF 
nmf_res_dbs_treated <- rename_nmf_signatures(nmf_res_dbs_treated, dbs_signatures, cutoff = 0.8) 
colnames(nmf_res_dbs_treated$signatures) <- c("DBS-A", "DBS5-like")
rownames(nmf_res_dbs_treated$contribution) <- c("DBS-A", "DBS5-like")

# Visualize the profile of the signature
plot_main_dbs_contexts(nmf_res_dbs_treated$signatures, same_y = TRUE)+
  scale_fill_manual(values = dbs_palette[c(1, 3, 6, 10, 13, 16, 19, 22, 25, 28, 30)]) + 
  theme(legend.position = "none") + 
  ylab("Signature weight")

# Cosine similarity between the 2 signatures
cos_sim(nmf_res_dbs_treated$signatures[, 2], nmf_res_dbs_treated$signatures[,1]) 

# Relative contribution plot
plot_contribution(nmf_res_dbs_treated$contribution, nmf_res_dbs_treated$signature,
  mode = "relative", palette = dbs_palette[c(28, 6)]
) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Original vs reconstructed plot
orig_vs_recons_dbs_treated <- cos_sim_matrix(dbs_matrix_treated, nmf_res_dbs_treated$reconstructed)
cos_sim_values_dbs_treated <- diag(orig_vs_recons_dbs_treated)

cos_sim_df_dbs_treated <- data.frame(Sample = colnames(orig_vs_recons_dbs_treated), Cosine_Similarity = cos_sim_values_dbs_treated)

ggplot(cos_sim_df_dbs_treated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = dbs_palette[9]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10), 
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank())


                                                                         
