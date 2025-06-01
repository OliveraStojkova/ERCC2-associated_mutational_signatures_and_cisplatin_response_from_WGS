# main indel context
plot_main_indel_contexts(indel_mut_matrix, same_y = TRUE) + 
  scale_fill_manual(values = c_palette[c(1, 4, 8, 11, 15, 18, 22, 25, 28, 30, 2, 10, 20, 13, 26, 23)]) + 
  theme(legend.position = "none") 


# main dbs context
plot_main_dbs_contexts(dbs_matrix, same_y = TRUE) + 
  scale_fill_manual(values = dbs_palette[c(1, 3, 6, 10, 13, 16, 19, 22, 25, 28, 30)]) + 
  theme(legend.position = "none")
