#! /bin/bash
#SBATCH --job-name=parse
#SBATCH --output=parse.out
#SBATCH --error=parse.err
#SBATCH -A p31629
#SBATCH -p short
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --mem=30Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all
module load qiime2/2023.2

cd /projects/p31629/cando_16S/qiime_io

qiime cutadapt trim-paired \
--i-demultiplexed-sequences reads.qza \
--o-trimmed-sequences reads_trim.qza \
--p-front-f GTGYCAGCMGCCGCGGTAA \
--p-front-r CCGYCAATTYMTTTRAGTTT \
--p-discard-untrimmed

qiime vsearch merge-pairs --verbose --p-threads 4 \
--i-demultiplexed-seqs reads_trim.qza \
--o-merged-sequences reads_trim_merge.qza

qiime demux summarize \
--i-data reads.qza \
--o-visualization readquality_raw.qzv

qiime demux summarize \
--i-data reads_trim.qza \
--o-visualization readquality_trim.qzv

qiime demux summarize \
--i-data reads_trim_merge.qza \
--o-visualization readquality_trim_merge.qzv

