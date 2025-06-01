# Strict refitting
fit_res_dbs_untreated <- fit_to_signatures_strict(dbs_matrix_untreated, dbs_signatures[, c("DBS4", "DBS2", "DBS11")], max_delta = 0.0002)
fit_res_dbs_treated <- fit_to_signatures_strict(dbs_matrix_treated, dbs_signatures[, bladder_cisplatin_dbs], max_delta = 0.0002)

# Relative contribution plots
plot_contribution(fit_res_dbs_treated$fit_res$contribution,
  coord_flip = FALSE,
  mode = "relative", palette = dbs_palette[c(6, 13, 22, 28)]
) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


plot_contribution(fit_res_dbs_untreated$fit_res$contribution,
  coord_flip = FALSE,
  mode = "relative", palette = dbs_palette[c(6, 13, 22, 28)]
) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#### Absolute contribution plots, first scale the contribution so it shows absolute numbers - TREATED
total_muts_treated <- colSums(dbs_matrix_treated)
raw_contrib_treated <- fit_res_dbs_treated$fit_res$contribution
signature_props_treated <- apply(raw_contrib_treated, 2, function(x) x / sum(x))
contrib_scaled_treated <- sweep(signature_props_treated, 2, total_muts_treated, `*`)

plot_contribution(contrib_scaled_treated,
  mode = "absolute",
  palette = dbs_palette[c(6, 13, 22, 28)]
) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

#### Absolute contribution plots, first scale the contribution so it shows absolute numbers - UNTREATED
total_muts_untreated <- colSums(dbs_matrix_untreated)
raw_contrib_untreated <- fit_res_dbs_untreated$fit_res$contribution
signature_props_untreated <- apply(raw_contrib_untreated, 2, function(x) x / sum(x))
contrib_scaled_untreated <- sweep(signature_props_untreated, 2, total_muts_untreated, `*`)

plot_contribution(contrib_scaled_untreated,
  mode = "absolute",
  palette = dbs_palette[c(13, 22, 28)]
) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

                                 
# Original vs reconstructed - TREATED
orig_vs_recons_dbs_treated_nnls <- cos_sim_matrix(dbs_matrix_treated, fit_res_dbs_treated$fit_res$reconstructed)
cos_sim_values_dbs_treated_nnls <- diag(orig_vs_recons_dbs_treated_nnls)

cos_sim_df_dbs_treated_nnls <- data.frame(Sample = colnames(orig_vs_recons_dbs_treated_nnls), Cosine_Similarity = cos_sim_values_dbs_treated_nnls)

ggplot(cos_sim_df_dbs_treated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = dbs_palette[9]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank() )

# Original vs reconstructed - UNTREATED
orig_vs_recons_dbs_untreated_nnls <- cos_sim_matrix(dbs_matrix_untreated, fit_res_dbs_untreated$fit_res$reconstructed)
cos_sim_values_dbs_untreated_nnls <- diag(orig_vs_recons_dbs_untreated_nnls)

cos_sim_df_dbs_untreated_nnls <- data.frame(Sample = colnames(orig_vs_recons_dbs_untreated_nnls), Cosine_Similarity = cos_sim_values_dbs_untreated_nnls)

ggplot(cos_sim_df_dbs_untreated, aes(x = Sample, y = Cosine_Similarity)) +
  geom_bar(stat = "identity", fill = dbs_palette[9]) + 
  labs(title = "Cosine Similarity Between Original and Reconstructed Vectors for Each Sample",
       x = "Sample", y = "Cosine Similarity") +
  geom_hline(yintercept = 0.95, linetype = 'dashed', color = "black") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank() )
