library("NMF")

# Separate the treated and untreated samples - separate NMF run 
sbs_mutation_matrix_treated <- sbs_mutation_matrix[, grep("cis", colnames(sbs_mutation_matrix))]
sbs_mutation_matrix_untreated <- sbs_mutation_matrix[, grep("untreated", colnames(sbs_mutation_matrix))]

# NMF rank survey to estimate the number of signatures to be extracted
estimate_treated <- nmf(sbs_mutation_matrix_treated, rank = 2:8, method = "brunet", 
                nrun = 10, seed = 123456, .opt = "v-p")

estimate_untreated <- nmf(sbs_mutation_matrix_untreated, rank = 2:5, method = "brunet", 
                nrun = 10, seed = 123456, .opt = "v-p")

plot(estimate_treated)
plot(estimate_untreated)

# Extract signatures
nmf_res_sbs_treated <- extract_signatures(sbs_mutation_matrix_treated, rank = 2, nrun = 10, single_core = TRUE)
nmf_res_sbs_untreated <- extract_signatures(sbs_mutation_matrix_untreated, rank = 2, nrun = 10, single_core = TRUE)

# Get known cosmic signatures
sbs_signatures <- get_known_signatures(genome = "GRCh38")

# Rename the signatures extracted by NMF
nmf_res_sbs_treated <- rename_nmf_signatures(nmf_res_sbs_treated, sbs_signatures, cutoff = 0.9) 
nmf_res_sbs_untreated <- rename_nmf_signatures(nmf_res_sbs_untreated, sbs_signatures, cutoff = 0.86) 

rownames(nmf_res_sbs_treated$contribution) <- c("SBS40-like", "SBS31-like")
rownames(nmf_res_sbs_untreated$contribution) <- c("SBS-A" , "SBS40-like")

# Cosine similarity between the extracted signatures
cos_sim(nmf_res_sbs_treated$signatures[, 1], nmf_res_sbs_treated$signatures[, 2]) 
cos_sim(nmf_res_sbs_untreated$signatures[, 1], nmf_res_sbs_untreated$signatures[, 2]) 

# Visualize the signatures profiles
plot_96_profile(nmf_res_sbs_treated$signatures, colors = color_palette[c(1:5, 7)])
plot_96_profile(nmf_res_sbs_untreated$signatures, colors = color_palette[c(1:5, 7)])

# Relative contribution of each signature to each sample
plot_contribution(nmf_res_sbs_treated$contribution, nmf_res_sbs_treated$signature,
  mode = "relative", palette = color_palette
) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

plot_contribution(nmf_res_sbs_untreated$contribution, nmf_res_sbs_untreated$signature,
  mode = "relative", palette = color_palette
) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Original vs. reconstructed plot -- for treated samples
orig_vs_recons_sbs_treated <- cos_sim_matrix(sbs_mutation_matrix_treated, nmf_res_sbs_treated$reconstructed)
cos_sim_values_sbs_treated <- diag(orig_vs_recons_sbs_treated)

cos_sim_df_sbs_treated <- data.frame(Sample = colnames(orig_vs_recons_sbs_treated), Cosine_Similarity = cos_sim_values_sbs_treated)

ggplot(cos_sim_df_sbs_treated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = color_palette[8]) +  
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank())

# Original vs. reconstructed plot -- for untreated samples
orig_vs_recons_sbs_untreated <- cos_sim_matrix(sbs_mutation_matrix_untreated, nmf_res_sbs_untreated$reconstructed)
cos_sim_values_sbs_untreated <- diag(orig_vs_recons_sbs_untreated)

cos_sim_df_sbs_untreated <- data.frame(Sample = colnames(orig_vs_recons_sbs_untreated), Cosine_Similarity = cos_sim_values_sbs_untreated)

ggplot(cos_sim_df_sbs_untreated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = color_palette[3]) +  
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank())

### Absolute contribution plots
# Reconstruct full mutation matrix from signature * contribution
reconstructed_treated <- nmf_res_sbs_treated$signatures %*% nmf_res_sbs_treated$contribution
reconstructed_untreated <- nmf_res_sbs_untreated$signatures %*% nmf_res_sbs_untreated$contribution

# Total mutations per sample 
total_mutations_per_sample_treated <- colSums(reconstructed_treated)
total_mutations_per_sample_untreated <- colSums(reconstructed_untreated)

# Normalize contributions to reflect total mutation counts
scaled_contributions_treated <- apply(nmf_res_sbs_treated$contribution, 2, function(x) {
  total <- sum(x)
  if (total == 0) return(x)
  x / total
})  

scaled_contributions_untreated <- apply(nmf_res_sbs_untreated$contribution, 2, function(x) {
  total <- sum(x)
  if (total == 0) return(x)
  x / total
})  

# Multiply by actual total mutations
contribution_absolute_treated <- sweep(scaled_contributions_treated, 2, total_mutations_per_sample_treated, `*`)
contribution_absolute_untreated <- sweep(scaled_contributions_untreated, 2, total_mutations_per_sample_untreated, `*`)

# Plot with mutation counts
plot_contribution(contribution_absolute_treated, nmf_res_sbs_treated$signatures,
  mode = "absolute", palette = color_palette
) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

plot_contribution(contribution_absolute_untreated, nmf_res_sbs_untreated$signatures,
  mode = "absolute", palette = color_palette
) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
