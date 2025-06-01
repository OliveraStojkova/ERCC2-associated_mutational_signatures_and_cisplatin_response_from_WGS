# Refitting was performed together on treated and untreated samples, 
# because there weren't any ID signatures specifically associated with cisplatin treatment

# Strict refitting
fit_res_indel <- fit_to_signatures_strict(indel_mut_matrix, indel_signatures[, bladder_indel], max_delta = 0.0002)

# Plot relative contribution
plot_contribution(fit_res_indel$fit_res$contribution,
  coord_flip = FALSE,
  mode = "relative", palette = c_palette[c(1, 4, 7, 12, 18, 24, 27, 30)]
) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))

# Original vs reconstructed 
orig_vs_recons_indel_nnls <- cos_sim_matrix(indel_mut_matrix, fit_res_indel$fit_res$reconstructed)
cos_sim_values_indel_nnls <- diag(orig_vs_recons_indel_nnls)

cos_sim_df_indel_nnls <- data.frame(Sample = colnames(orig_vs_recons_indel_nnls), Cosine_Similarity = cos_sim_values_indel_nnls)

ggplot(cos_sim_df_indel_nnls, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = c_palette[10]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        panel.grid.major = element_blank(),  
      panel.grid.minor = element_blank())

## Absolute contribution plot, but first scale the numbers so that actual mutation counts are shown
total_muts_id <- colSums(indel_mut_matrix)
raw_contrib_id <- fit_res_indel$fit_res$contribution
signature_props_id <- apply(raw_contrib_id, 2, function(x) x / sum(x))
contrib_scaled_id <- sweep(signature_props_id, 2, total_muts_id, `*`)

plot_contribution(contrib_scaled_id,
  mode = "absolute",
  palette = c_palette[c(1, 4, 7, 12, 18, 24, 27, 30)]
) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
