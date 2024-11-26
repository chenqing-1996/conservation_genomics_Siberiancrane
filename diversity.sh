#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-diversity-%j.out
#SBATCH --error=slurm-diversity-%j.err

echo ==========selectSNP starts at `date`==========

##load software
module load vcftools

##heterozygote EA population
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCA_ID.txt --het --out SCA 
##heterozygote WCAA population
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCW_ID.txt --het --out SCW 
##pi WCA population
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCW_ID.txt --window-pi 50000 --window-pi-step 20000 --out SCW 
##pi EA population
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCA_ID.txt --window-pi 50000 --window-pi-step 20000 --out SCA
##fst
vcftools --vcf path/to/SC_withoutsexcontig.vcf --weir-fst-pop path/to/SCA_ID.txt --weir-fst-pop path/to/SCW_ID.txt --fst-window-size 50000 --fst-window-step 20000 --out SC 
## Tajima's D
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCA_ID.txt --TajimaD 50000 --out SCA 
vcftools --vcf path/to/SC_withoutsexcontig.vcf --keep path/to/SCW_ID.txt --TajimaD 50000 --out SCW 

echo ==========selectSNP starts at `date`==========