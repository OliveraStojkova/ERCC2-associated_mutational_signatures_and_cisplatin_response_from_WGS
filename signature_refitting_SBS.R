only_bladder_sbs <- c("SBS1", "SBS2", "SBS5", "SBS8", "SBS13", "SBS29", "SBS40")

# Strict refitting
fit_res_sbs_treated <- fit_to_signatures_strict(sbs_mutation_matrix_treated, sbs_signatures[, bladder_cisplatin_sbs], max_delta = 0.0002)
fit_res_sbs_untreated <- fit_to_signatures_strict(sbs_mutation_matrix_untreated, sbs_signatures[, only_bladder_sbs], max_delta = 0.0002)

# Relative contribution plot
plot_contribution(fit_res_sbs_treated$fit_res$contribution,
  coord_flip = FALSE,
  mode = "relative", palette = color_palette
) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

plot_contribution(fit_res_sbs_untreated$fit_res$contribution,
  coord_flip = FALSE,
  mode = "relative", palette = color_palette
) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

### Plot absolute contribution plots - first scale so that the exact nuber of mutations are shown - TREATED
total_muts_sbs_treated <- colSums(sbs_mutation_matrix_treated)
raw_contrib_sbs_treated <- fit_res_sbs_treated$fit_res$contribution
signature_props_sbs_treated <- apply(raw_contrib_sbs_treated, 2, function(x) x / sum(x))
contrib_scaled_sbs_treated <- sweep(signature_props_sbs_treated, 2, total_muts_sbs_treated, `*`)

plot_contribution(contrib_scaled_sbs_treated,
  mode = "absolute",
  palette = color_palette
) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

### Plot absolute contribution plots - first scale so that the exact nuber of mutations are shown - UNTREATED
total_muts_sbs_untreated <- colSums(sbs_mutation_matrix_untreated)
raw_contrib_sbs_untreated <- fit_res_sbs_untreated$fit_res$contribution
signature_props_sbs_untreated <- apply(raw_contrib_sbs_untreated, 2, function(x) x / sum(x))
contrib_scaled_sbs_untreated <- sweep(signature_props_sbs_untreated, 2, total_muts_sbs_untreated, `*`)

plot_contribution(contrib_scaled_sbs_untreated,
  mode = "absolute",
  palette = color_palette
) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Original vs reconstructed - TREATED
orig_vs_recons_sbs_treated_nnls <- cos_sim_matrix(sbs_mutation_matrix_treated, fit_res_sbs_treated$fit_res$reconstructed)
cos_sim_values_sbs_treated_nnls <- diag(orig_vs_recons_sbs_treated_nnls)

cos_sim_df_sbs_treated_nnls <- data.frame(Sample = colnames(orig_vs_recons_sbs_treated_nnls), Cosine_Similarity = cos_sim_values_sbs_treated_nnls)

ggplot(cos_sim_df_sbs_treated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = color_palette[8]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank() )

# Original vs reconstructed - UNTREATED
orig_vs_recons_sbs_untreated_nnls <- cos_sim_matrix(sbs_mutation_matrix_untreated, fit_res_sbs_untreated$fit_res$reconstructed)
cos_sim_values_sbs_untreated_nnls <- diag(orig_vs_recons_sbs_untreated_nnls)

cos_sim_df_sbs_untreated_nnls <- data.frame(Sample = colnames(orig_vs_recons_sbs_untreated_nnls), Cosine_Similarity = cos_sim_values_sbs_untreated_nnls)

ggplot(cos_sim_df_sbs_untreated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = color_palette[3]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank() )
