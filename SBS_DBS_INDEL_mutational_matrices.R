library(MutationalPatterns)

# Rename columns to match the required input 
colnames(isomut_output)[which(colnames(isomut_output) == "ref")] <- "REF"
colnames(isomut_output)[which(colnames(isomut_output) == "mut")] <- "ALT"

# Reference genome
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
reference <- "BSgenome.Hsapiens.UCSC.hg38"
library(reference, character.only = TRUE)

# Retrieve SBSs
sbs_only <- subset(isomut_output, nchar(REF) == 1 & nchar(ALT) == 1)

sbs_grl <- makeGRangesListFromDataFrame(
  df = sbs_only,
  seqnames.field = "chr",
  start.field = "start",
  end.field = "end",
  split.field = "sample_name",
  keep.extra.columns = TRUE,
  starts.in.df.are.0based = FALSE
)

GenomeInfoDb::genome(sbs_grl) = 'hg38'

sbs_mutation_matrix <- mut_matrix(sbs_grl, reference) 
colSums(sbs_mutation_matrix)

# Retrieve dbs - by collapsing two neighboring SBSs
dbs_grl_new <- get_mut_type(sbs_grl, type = 'dbs')

GenomeInfoDb::genome(dbs_grl_new) = 'hg38'

# DBS mutational matrix
# Some SNVs or indels might've slipped, filter so it only considers those 2 bp long 

dbs_grl_clean <- endoapply(dbs_grl_new, function(gr) {
  ref <- as.character(mcols(gr)$REF)
  alt <- as.character(unlist(mcols(gr)$ALT))

  # Keep only those where both REF and ALT are 2 bases and valid (A/C/G/T only)
  is_valid <- nchar(ref) == 2 & nchar(alt) == 2 &
              grepl("^[ACGT]{2}$", ref) &
              grepl("^[ACGT]{2}$", alt)

  gr[is_valid]
})

dbs_ctx <- get_dbs_context(dbs_grl_clean)
dbs_matrix <- count_dbs_contexts(dbs_ctx)

# INDEL mut matrix
# To make the idnels work, i need to format the REF and ALT columns properly in a VCF-like format, such that for insertion I shouldn't have -, but instead I should have the base before the insertion (ex. A is REF and then AG is ALT, meaning insetion of G after A)
# For deletion REF = AGT and ALT=A mening GT deletion after A

# To fix this I need to look up the reference base before the indel position (pos-1) and thne modify REF and ALT to include that anchor base
library(BSgenome.Hsapiens.UCSC.hg38)
hg38_genome <- BSgenome.Hsapiens.UCSC.hg38

indels_only <- isomut_output %>%
   filter(type %in% c("INS", "DEL")) %>%
   mutate(
     anchor_pos = pos - 1,
     anchor_base = as.character(getSeq(hg38_genome, chr, anchor_pos, anchor_pos)),
     # Reformat REF and ALT
     REF = ifelse(type == "INS",
                  anchor_base,
                  paste0(anchor_base, REF)),
     
     ALT = ifelse(type == "INS",
                  paste0(anchor_base, ALT),
                  anchor_base)
 )


indel_grl <- makeGRangesListFromDataFrame(
  df = indels_only,
  seqnames.field = "chr",
  start.field = "start",
  end.field = "end",
  split.field = "sample_name",
  keep.extra.columns = TRUE,
  starts.in.df.are.0based = FALSE
)

GenomeInfoDb::genome(indel_grl) = 'hg38'

indel_context <- get_indel_context(indel_grl, reference)
indel_mut_matrix <- count_indel_contexts(indel_context) 
