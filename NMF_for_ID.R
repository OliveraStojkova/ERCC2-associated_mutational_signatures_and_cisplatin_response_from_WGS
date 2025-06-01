# Separate treated and untreated
indel_mut_matrix_treated <- indel_mut_matrix[,grep("cis", colnames(sbs_mutation_matrix))]
indel_mut_matrix_untreated <- indel_mut_matrix[, grep("untreated", colnames(sbs_mutation_matrix))]

# Check the number of indels per sample
colSums(indel_mut_matrix_treated)
colSums(indel_mut_matrix_untreated) # Very low number of mutations -> perform NMF only on the treated samples

# Add a small pseudocount for the 0 values 
indel_mut_matrix_treated_w_pseudocount <- indel_mut_matrix_treated + 0.0001

estimate_indels_treated <- nmf(indel_mut_matrix_treated_w_pseudocount, rank = 2:8, method = "brunet", 
                nrun = 10, seed = 123456, .opt = "v-p")

plot(estimate_indels_treated) 

# Extract signature
nmf_res_indels_treated <- extract_signatures(indel_mut_matrix_treated_w_pseudocount, rank = 1, nrun = 10, single_core = TRUE)

# Get known cosmic signatures
indel_signatures <- get_known_signatures(muttype = "indel", genome = "GRCh37")

# Rename the signatures extracted by NMF 
nmf_res_indels_treated <- rename_nmf_signatures(nmf_res_indels_treated, indel_signatures, cutoff = 0.6) 

# Visualize the signature progile
plot_main_indel_contexts(nmf_res_indels_treated$signatures, same_y = TRUE) +
  scale_fill_manual(values = c_palette[c(1, 4, 8, 11, 15, 18, 22, 25, 28, 30, 2, 10, 20, 13, 26, 23)]) + 
  theme(legend.position = "none") + 
  ylab("Signature weight")

# Original vs. reconstructed plot
orig_vs_recons_indel_treated <- cos_sim_matrix(indel_mut_matrix_treated, nmf_res_indels_treated$reconstructed)
cos_sim_values_indel_treated <- diag(orig_vs_recons_indel_treated)

cos_sim_df_indel_treated <- data.frame(Sample = colnames(orig_vs_recons_indel_treated), Cosine_Similarity = cos_sim_values_indel_treated)

ggplot(cos_sim_df_indel_treated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = c_palette[10]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank())
