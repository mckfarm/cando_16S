#! /bin/bash
#SBATCH --job-name=import
#SBATCH --output=import.out
#SBATCH --error=import.err
#SBATCH -A p31629
#SBATCH -p short
#SBATCH -t 01:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=30Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all
module load qiime2/2023.2

cd /projects/p31629/cando_16S/qiime_io

qiime tools import \
--input-path manifest.txt \
--output-path reads.qza \
--input-format PairedEndFastqManifestPhred33V2 \
--type SampleData[PairedEndSequencesWithQuality]
