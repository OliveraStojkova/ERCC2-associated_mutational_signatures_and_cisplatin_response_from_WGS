# Subset of signatures associated with either just bladder cancer or bladder cancer+cisplatin
bladder_cisplatin_sbs <- c("SBS1", "SBS2", "SBS5", "SBS8", "SBS13", "SBS29", "SBS40", "SBS31", "SBS35")
bladder_cisplatin_dbs <- c("DBS2", "DBS4", "DBS11", "DBS5")
bladder_indel <- c("ID1", "ID2", "ID3", "ID4", "ID5", "ID8", "ID9", "ID10")

# Cosine similarity of SBS (treated and untreated separately) with COSMIC signatures
cos_sim_samples_sbs_signatures_treated <- cos_sim_matrix( nmf_res_sbs_treated$signatures, sbs_signatures[, bladder_cisplatin_sbs])
cos_sim_samples_sbs_signatures_untreated <- cos_sim_matrix(nmf_res_sbs_untreated$signatures, sbs_signatures[, c("SBS1", "SBS2", "SBS5", "SBS8", "SBS13", "SBS29", "SBS40")])

# Cosine similarity of DBS (treated and untreated separately) with COSMIC signatures
cos_sim_samples_dbs_signatures_treated <- cos_sim_matrix(nmf_res_dbs_treated$signatures, dbs_signatures[, bladder_cisplatin_dbs])

# Cosine similarity of ID (treated and untreated separately) with COSMIC signatures
cos_sim_samples_id_signatures_treated <- cos_sim_matrix(nmf_res_indels_treated$signatures, indel_signatures[, bladder_indel] )

# make heatmaps
library(pheatmap)

gradient_colors <- c("#FDDBC7FF", "#B2182BFF", "#67001FFF")
gradient_colors_1 <- c("#F8F8BBFF", "#822D3FFF", "#4B112DFF")
gradient_colors_2 <- c("#E4E1B4FF","#C7522BFF", "#778C6AFF")
gradient_colors_3 <- c_palette[c(7, 13, 25)]

# This plot was used to generate all heatmaps (Figure 2, Figure 3, Figure 4, Figure 6)
pheatmap(cos_sim_samples_sbs_signatures_treated,
         color = colorRampPalette(gradient_colors)(10),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         main = "Cosine Similarity Heatmap",
         display_numbers = TRUE,
         number_color = "black",
         breaks = seq(0, 1, length.out = 10))

# ID signatures pairwise cosine similarity
cos_sim_samples_id_signatures <- cos_sim_matrix(nmf_res_indels_treated$signatures, nmf_res_indels_treated$signatures)

# COSMIC ID signatures associated with BLCA pairwise cosine similarity
cos_sim_samples_id_bladder <- cos_sim_matrix(indel_signatures[, bladder_indel], indel_signatures[, bladder_indel])

# Heatmap used for Figure S11
pheatmap(cos_sim_samples_id_signatures,
         color = colorRampPalette(gradient_colors_2)(10),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         main = "Cosine Similarity Heatmap",
         display_numbers = TRUE,
         number_color = "black",
         breaks = seq(0, 1, length.out = 10))

pheatmap(cos_sim_samples_id_bladder,
         color = colorRampPalette(gradient_colors_3)(10),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         main = "Cosine Similarity Heatmap",
         display_numbers = TRUE,
         number_color = "black",
         breaks = seq(0, 1, length.out = 10))

