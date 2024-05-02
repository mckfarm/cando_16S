#! /bin/bash
#SBATCH --job-name=tree
#SBATCH --output=tree.out
#SBATCH --error=tree.err
#SBATCH -A p31629
#SBATCH -p normal
#SBATCH -t 02:00:00
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --mem=20Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all
module load qiime2/2023.2

cd /projects/p31629/cando_16S/qiime_io

qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences rep_seqs_deblur.qza \
--o-alignment rep_seqs_deblur_aligned.qza \
--o-masked-alignment rep_seqs_deblur_aligned_masked.qza \
--o-tree unrooted_tree.qza \
--o-rooted-tree rooted_tree.qza