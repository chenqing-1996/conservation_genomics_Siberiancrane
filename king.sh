#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-kinship-%j.out
#SBATCH --error=slurm-kinship-%j.err

echo ==========selectSNP starts at `date`==========
##load software
module load bcftools/1.21-gcc-11.4.0
module load plink/v1.9.0-gcc-11.4.0
sotware="path/to/software"

##addID
bcftools annotate --set-id +'%CHROM\_%POS' path/to/allsample.filter.snp.vcf -o path/to/allsample.filter.snp.ID.vcf

##get plinkfile
plink --vcf path/to/allsample.filter.snp.ID.vcf --recode --out outdir/SC.plink --const-fid --allow-extra-chr

##make bedfile
plink --allow-extra-chr --file outdir/SC.plink --noweb --make-bed --out outdir/SC.plinkbed

##calculating pair-wise kinship coefficients
$software/king -b outdir/SC.plinkbed --kinship

echo ==========selectSNP ends at `date`==========