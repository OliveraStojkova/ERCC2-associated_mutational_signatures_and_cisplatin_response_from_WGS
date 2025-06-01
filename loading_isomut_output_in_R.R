# The isomut output was generated separately for each chromosome 

# SNVs
chr1_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs1.isomut", header = TRUE, stringsAsFactors = FALSE)
chr2_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs2.isomut", header = TRUE, stringsAsFactors = FALSE)
chr3_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs3.isomut", header = TRUE, stringsAsFactors = FALSE)
chr4_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs4.isomut", header = TRUE, stringsAsFactors = FALSE)
chr5_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs5.isomut", header = TRUE, stringsAsFactors = FALSE)
chr6_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs6.isomut", header = TRUE, stringsAsFactors = FALSE)
chr7_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs7.isomut", header = TRUE, stringsAsFactors = FALSE)
chr8_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs8.isomut", header = TRUE, stringsAsFactors = FALSE)
chr9_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs9.isomut", header = TRUE, stringsAsFactors = FALSE)
chr10_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs10.isomut", header = TRUE, stringsAsFactors = FALSE)
chr11_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs11.isomut", header = TRUE, stringsAsFactors = FALSE)
chr12_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs12.isomut", header = TRUE, stringsAsFactors = FALSE)
chr13_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs13.isomut", header = TRUE, stringsAsFactors = FALSE)
chr14_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs14.isomut", header = TRUE, stringsAsFactors = FALSE)
chr15_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs15.isomut", header = TRUE, stringsAsFactors = FALSE)
chr16_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs16.isomut", header = TRUE, stringsAsFactors = FALSE)
chr17_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs17.isomut", header = TRUE, stringsAsFactors = FALSE)
chr18_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs18.isomut", header = TRUE, stringsAsFactors = FALSE)
chr19_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs19.isomut", header = TRUE, stringsAsFactors = FALSE)
chr20_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs20.isomut", header = TRUE, stringsAsFactors = FALSE)
chr21_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs21.isomut", header = TRUE, stringsAsFactors = FALSE)
chr22_snv <- read.delim("isomut_workin_output_13_samples/all_SNVs22.isomut", header = TRUE, stringsAsFactors = FALSE)

all_snvs <- rbind(chr1_snv, chr2_snv, chr3_snv, chr4_snv, chr5_snv, chr6_snv, chr7_snv, chr8_snv, chr9_snv, chr10_snv, chr11_snv, chr12_snv, chr13_snv, chr14_snv, chr15_snv, chr16_snv, chr17_snv, chr18_snv, chr19_snv, chr20_snv, chr21_snv, chr22_snv)

# INDELS
chr1_indel <- read.delim("isomut_workin_output_13_samples/all_indels1.isomut", header = TRUE, stringsAsFactors = FALSE)
chr2_indel <- read.delim("isomut_workin_output_13_samples/all_indels2.isomut", header = TRUE, stringsAsFactors = FALSE)
chr3_indel <- read.delim("isomut_workin_output_13_samples/all_indels3.isomut", header = TRUE, stringsAsFactors = FALSE)
chr4_indel <- read.delim("isomut_workin_output_13_samples/all_indels4.isomut", header = TRUE, stringsAsFactors = FALSE)
chr5_indel <- read.delim("isomut_workin_output_13_samples/all_indels5.isomut", header = TRUE, stringsAsFactors = FALSE)
chr6_indel <- read.delim("isomut_workin_output_13_samples/all_indels6.isomut", header = TRUE, stringsAsFactors = FALSE)
chr7_indel <- read.delim("isomut_workin_output_13_samples/all_indels7.isomut", header = TRUE, stringsAsFactors = FALSE)
chr8_indel <- read.delim("isomut_workin_output_13_samples/all_indels8.isomut", header = TRUE, stringsAsFactors = FALSE)
chr9_indel <- read.delim("isomut_workin_output_13_samples/all_indels9.isomut", header = TRUE, stringsAsFactors = FALSE)
chr10_indel <- read.delim("isomut_workin_output_13_samples/all_indels10.isomut", header = TRUE, stringsAsFactors = FALSE)
chr11_indel <- read.delim("isomut_workin_output_13_samples/all_indels11.isomut", header = TRUE, stringsAsFactors = FALSE)
chr12_indel <- read.delim("isomut_workin_output_13_samples/all_indels12.isomut", header = TRUE, stringsAsFactors = FALSE)
chr13_indel <- read.delim("isomut_workin_output_13_samples/all_indels13.isomut", header = TRUE, stringsAsFactors = FALSE)
chr14_indel <- read.delim("isomut_workin_output_13_samples/all_indels14.isomut", header = TRUE, stringsAsFactors = FALSE)
chr15_indel <- read.delim("isomut_workin_output_13_samples/all_indels15.isomut", header = TRUE, stringsAsFactors = FALSE)
chr16_indel <- read.delim("isomut_workin_output_13_samples/all_indels16.isomut", header = TRUE, stringsAsFactors = FALSE)
chr17_indel <- read.delim("isomut_workin_output_13_samples/all_indels17.isomut", header = TRUE, stringsAsFactors = FALSE)
chr18_indel <- read.delim("isomut_workin_output_13_samples/all_indels18.isomut", header = TRUE, stringsAsFactors = FALSE)
chr19_indel <- read.delim("isomut_workin_output_13_samples/all_indels19.isomut", header = TRUE, stringsAsFactors = FALSE)
chr20_indel <- read.delim("isomut_workin_output_13_samples/all_indels20.isomut", header = TRUE, stringsAsFactors = FALSE)
chr21_indel <- read.delim("isomut_workin_output_13_samples/all_indels21.isomut", header = TRUE, stringsAsFactors = FALSE)
chr22_indel <- read.delim("isomut_workin_output_13_samples/all_indels22.isomut", header = TRUE, stringsAsFactors = FALSE)

all_indels <- rbind(chr1_indel, chr2_indel, chr3_indel, chr4_indel, chr5_indel, chr6_indel, chr7_indel, chr8_indel, chr9_indel, chr10_indel, chr11_indel, chr12_indel, chr13_indel, chr14_indel, chr15_indel, chr16_indel, chr17_indel, chr18_indel, chr19_indel, chr20_indel, chr21_indel, chr22_indel)

isomut_output <- rbind(all_snvs, all_indels)

colnames(isomut_output)[which(colnames(isomut_output) == "X.sample_name")] <- "sample_name"
isomut_output <- isomut_output %>% mutate(sample_name = gsub("\\.bam$", "", sample_name))

isomut_output <- isomut_output %>%
  mutate(sample_name = case_when(
    sample_name == "Sample_1" ~ "wt_0.5cis_4w",
    sample_name == "Sample_2" ~ "wt_1cis_4w",
    sample_name == "Sample_3" ~ "wt_0.5cis_8w_1",
    sample_name == "Sample_4" ~ "wt_0.5cis_8w_2",
    sample_name == "Sample_5" ~ "wt_1cis_8w_1",
    sample_name == "Sample_6" ~ "wt_1cis_8w_2",
    sample_name == "Sample_7" ~ "wt_untreated",
    sample_name == "Sample_8" ~ "wt_untreated_1",
    sample_name == "Sample_9" ~ "wt_untreated_2",
    sample_name == "Sample_10" ~ "mut_0.5cis_4w_1",
    sample_name == "Sample_11" ~ "mut_0.5cis_4w_2",
    sample_name == "Sample_12" ~ "mut_untreated_1",
    sample_name == "Sample_13" ~ "mut_untreated_2",
    TRUE ~ sample_name  # keep other names as they are
  ))
