#########################################################
# purpose: extract relevant info from blast results
# notes: parse_qiime and extract_seqs go first
#########################################################

library(tidyverse)

onedrive_path <- "~/OneDrive - Northwestern University/Project folders/CANDO 16S/blast"

taxonomy <- read_delim(file.path("~/OneDrive - Northwestern University/Project folders/CANDO 16S/blast/midas_5.3.txt"),
                       col_names = c("Kingdom", "Phylum", "Class",
                                     "Order", "Family", "Genus", "Species")) %>%
  separate(col = Kingdom, into = c("id", "Kingdom"), sep = "\\s") %>%
  mutate_at(vars(Kingdom:Species), ~ str_replace(., ";", "")) %>%
  mutate_at(vars(Kingdom:Species), ~gsub(x = ., "[A-z]__", ""))

blast_comp <- read_delim(file.path(onedrive_path, "competibacter_blast.txt"), 
                         col_names = c("query", "subject", "pident", "length", 
                                       "mismatch", "gapopen", "qstart", "qend",
                                       "sstart", "send", "evalue", "bitscore"))

blast_dechloro <- read_delim(file.path(onedrive_path, "dechloromonas_blast.txt"), 
                             col_names = c("query", "subject", "pident", "length", 
                                           "mismatch", "gapopen", "qstart", "qend",
                                           "sstart", "send", "evalue", "bitscore"))

tax_comp <- blast_comp %>%
  left_join(taxonomy, join_by("subject" == "id"))

tax_dechloro <- blast_dechloro %>%
  left_join(taxonomy, join_by("subject" == "id"))

rm(taxonomy, blast_comp, blast_dechloro)

tax_dechloro <- tax_dechloro %>% filter(pident >= 99)

saveRDS(tax_dechloro, file = file.path("~/OneDrive - Northwestern University/Project folders/CANDO 16S/parsed data/dechloro_blast.RDS"))

