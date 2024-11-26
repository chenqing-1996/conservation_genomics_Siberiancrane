#!/bin/bash
#SBATCH -p mars
#SBATCH -j plink
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-pca-%j.out
#SBATCH --error=slurm-pca-%j.err

echo ==========selectSNP starts at `date`==========
##load software
module load plink/v1.9.0-gcc-11.4.0

#remove relative individuals
plink --allow-extra-chr --file SC.aut.plink --noweb --keep relativeind.txt --geno 0.05 --maf 0.05 --hwe 0.00001 --make-bed --out SC.aut.unrelated 
##change bim file chromosome name
sed 's/^[^\t]*/1\t/' SC.aut.unrelated.bim > SC.aut.unrelated.new.bim
mv SC.aut.unrelated.bim or_SC.aut.unrelated.bim && mv SC.aut.unrelated.new.bim SC.aut.unrelated.bim

##sort
plink --bfile SC.aut.unrelated --make-bed --out SC.aut.unrelated.sort

#LD filtering
plink --bfile SC.aut.unrelated.sort --indep-pairwise 50 20 0.2 --out SC.aut.unrelated.ld
plink --bfile SC.aut.unrelated.sort --extract SC.aut.unrelated.ld.prune.in --make-bed --out SC.aut.related.ldpurne

##pca
yhrun -p nsfc3 -N 1 -n 1 plink --threads 20 -bfile SCpurne --allow-extra-chr --pca 20 --out SC

echo ==========selectSNP ends at `date`==========