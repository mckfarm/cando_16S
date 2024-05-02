#! /bin/bash
#SBATCH --job-name=deblur
#SBATCH --output=deblur.out
#SBATCH --error=deblur.err
#SBATCH -A p31629
#SBATCH -p normal
#SBATCH -t 01:00:00
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --mem=20Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all
module load qiime2/2023.2

cd /projects/p31629/cando_16S/qiime_io

qiime deblur denoise-16S --verbose --p-jobs-to-start 6 \
--i-demultiplexed-seqs reads_trim_merge.qza \
--o-table table_deblur.qza \
--o-representative-sequences rep_seqs_deblur.qza \
--o-stats stats_deblur.qza \
--p-trim-length 368 \
--p-sample-stats

qiime deblur visualize-stats \
--i-deblur-stats stats_deblur.qza \
--o-visualization stats_deblur.qzv

qiime feature-table tabulate-seqs \
--i-data rep_seqs_deblur.qza \
--o-visualization rep_seqs_deblur.qzv