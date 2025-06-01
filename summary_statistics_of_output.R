# Calculate the total mutation counts per sample
total_counts <- isomut_output %>%
  group_by(sample_name) %>%
  summarise(num_mutations = n()) %>%
  mutate(type = "Total") %>%
  dplyr::select(sample_name, type, num_mutations)

# Count the number of mutations per sample and type (SNV, INS, DEL)
mutation_counts_by_type <- isomut_output %>%
  group_by(sample_name, type) %>%
  tally() %>%
  rename(num_mutations = n)

# Summary Statistics
combined_counts <- bind_rows(mutation_counts_by_type, total_counts)

summary_stats <- combined_counts %>%
  group_by(type) %>%
  summarise(
    Mean = mean(num_mutations),
    Median = median(num_mutations),
    Min = min(num_mutations),
    Max = max(num_mutations),
    SD = sd(num_mutations),
    .groups = 'drop'
  ) %>%
  mutate(across(where(is.numeric), round, 2))

# Plot total number of mutations per sample
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

