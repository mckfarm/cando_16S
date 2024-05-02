#! /bin/bash
#SBATCH --job-name=taxonomy
#SBATCH --output=taxonomy.out
#SBATCH --error=taxonomy.err
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

qiime feature-classifier classify-sklearn \
--i-classifier /projects/b1052/mckenna/resources/midas_5.3/midas_5.3_classifier.qza \
--i-reads rep_seqs_deblur.qza \
--o-classification taxonomy.qza