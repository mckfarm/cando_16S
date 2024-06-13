
library(tidyverse)
library(Biostrings)

onedrive_path <- "~/OneDrive - Northwestern University/Project folders/CANDO 16S/"
# onedrive_path <- "C:/Users/mckyf/OneDrive - Northwestern University/Project folders/CANDO 16S/"

ps_rel_list <- readRDS(file.path(onedrive_path, "./parsed data/ps_rel_list.RDS"))
asvs <- readDNAStringSet(file.path(onedrive_path, "./qiime/dna-sequences.fasta"), format = "fasta")

extract_seqs_by_taxonomy <- function(tax_table, seqs, tax_level, name_of_taxa){
  
  # tax_level should not be in quotes and should be in the case of the tax_table columns
  # name_of_taxa should be in quotes
  
  tax_level <- enquo(tax_level)
  
  seq_ids <- tax_table %>%
    filter(str_detect(!!tax_level, paste0("(?i)", name_of_taxa)))
  
  filtered_seqs <- seqs[seq_ids$seq]
  
  return(filtered_seqs)
  
}

dechloro_seqs <- extract_seqs_by_taxonomy(ps_rel_list[["tax"]], asvs, Genus, "Azonexus")
comp_seqs <- extract_seqs_by_taxonomy(ps_rel_list[["tax"]], asvs, Genus, "Competibacter")

writeXStringSet(dechloro_seqs, file.path(onedrive_path, "./parsed data/dechloro_seqs.fasta"))
writeXStringSet(comp_seqs, file.path(onedrive_path, "./parsed data/comp_seqs.fasta"))

