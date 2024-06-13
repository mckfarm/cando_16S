#########################################################
# purpose: parse qiime outputs to .RData
# notes: 
#########################################################

library(qiime2R)
library(phyloseq)
library(tibble)

onedrive_path <- "~/OneDrive - Northwestern University/Project folders/CANDO 16S/qiime"

ps <- qiime2R::qza_to_phyloseq(
  features = file.path(onedrive_path, "table_deblur.qza"),
  taxonomy = file.path(onedrive_path, "taxonomy.qza"),
  tree = file.path(onedrive_path, "rooted_tree.qza"),
  metadata = file.path(onedrive_path, "metadata.tsv")
)

ps_rel <- phyloseq::transform_sample_counts(ps, function(x) x*100/sum(x))

split_phyloseq <- function(phyloseq_obj, list_name){
  
  ls <- list()
  
  ab <- as(otu_table(phyloseq_obj), "matrix")
  ab <- as.data.frame(ab) %>%
    rownames_to_column(var = "seq")
  
  ls[["ab"]] <- ab
  
  tax <- as(tax_table(phyloseq_obj), "matrix")
  tax <- as.data.frame(tax) %>%
    rownames_to_column(var = "seq")
  
  ls[["tax"]] <- tax
  
  meta <- as(sample_data(phyloseq_obj), "matrix")
  meta <- as.data.frame(meta) %>%
    rownames_to_column(var = "sample")
  
  ls[["meta"]] <- meta
  
  assign(paste(list_name), ls, envir = parent.frame(n = 1))
  
}

split_phyloseq(ps_rel, "ps_rel_list")

saveRDS(ps_rel_list, file = "~/OneDrive - Northwestern University/Project folders/CANDO 16S/parsed data/ps_rel_list.RDS")

