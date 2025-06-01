library(paletteer)

color_palette <- paletteer_d("RColorBrewer::RdGy")
new_color_palette <- paletteer_c("ggthemes::Red-Black Diverging", 30)
c_palette <- paletteer_c("grDevices::Fall", 30)
dbs_palette <- paletteer_c("grDevices::Lajolla", 30)

#### Total number of mutations per sample plot - mutation_counts_by_type generated in summary_statistics.R 
mutation_counts_all_long <- mutation_counts_all %>%
  mutate(sample_name = factor(sample_name, levels = ordered_samples))

ggplot(mutation_counts_all_long, aes(x = sample_name, 
                                y = num_mutations)) +
  geom_col(fill = color_palette[2]) +
  geom_hline(yintercept = mean(mutation_counts_all$num_mutations), color = "black", linetype = "dashed")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 11), panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank()) +
  xlab(" ") +
  ylab("Mutation count")

#### INS/DEL counts plot - mutation_counts_by_type generated in summary_statistics.R 
mutation_counts_by_type_ins_del <- mutation_counts_by_type %>% filter(type %in% c("INS", "DEL"))
mutation_counts_by_type_ins_del$sample_name <- factor(mutation_counts_by_type_ins_del$sample_name,
                                               levels = unique(mutation_counts_by_type_ins_del$sample_name))

ordered_samples <- levels(snv_long$sample_name)

indel_long <- mutation_counts_by_type_ins_del %>%
  mutate(sample_name = factor(sample_name, levels = ordered_samples))

ggplot(indel_long, aes(x = sample_name, y = num_mutations, fill = type)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_manual(values = color_palette[c(1, 3)]) +
  theme_minimal() +
  labs(
    title = " ",
    y = "Indel count",
    x = "Sample"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank(),
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank(),
    legend.position = c(0.9, 0.85)
  )

#### DBS counts plot - dbs_matrix generated in SBS_DBS_INDEL_mutational_matrices.R
total_dbs <- colSums(dbs_matrix) 

df_dbs <- data.frame(
  Sample = names(total_dbs),
  DBS_Count = as.numeric(total_dbs)
)

df_dbs <- df_dbs %>%
  mutate(Sample = factor(Sample, levels = ordered_samples))

ggplot(df_dbs, aes(x = Sample, y = DBS_Count)) +
  geom_bar(stat = "identity", fill = color_palette[4]) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank(),
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank(),
    legend.position = c(0.9, 0.85)
  ) + labs(
    x = "Sample",
    y = "DBS Count"
  )

#### SNVs count plot - sbs_grl generated in SBS_DBS_INDEL_mutational_matrices.R
snv_type_occurrences <- mut_type_occurrences(sbs_grl, reference)

snv_long <- snv_type_occurrences %>%
  select(-c(`C>T at CpG`, `C>T other`)) %>%
  rownames_to_column("sample_name") %>%
  pivot_longer(
    cols = -sample_name,
    names_to = "substitution_type",
    values_to = "count"
  )

snv_long <- snv_long %>%
  mutate(sample_name = factor(sample_name, levels = c(
    sort(unique(sample_name[startsWith(sample_name, "wt")])),
    sort(unique(sample_name[startsWith(sample_name, "mut")]))
  )))

ggplot(snv_long, aes(x = sample_name, y = count, fill = substitution_type)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_manual(values = color_palette[c(1:5,7)]) +
  theme_minimal() +
  labs(
    title = " ",
    y = "SNV count",
    x = "Sample"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank(),
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank(),
    legend.position = c(0.9, 0.85)) 

