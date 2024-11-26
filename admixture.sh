#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-admixture-%j.out
#SBATCH --error=slurm-dmixture-%j.err

for k in 1 2 3 4 5 6 7 8 9 10; 

do admixture -B --cv path/to/SCpurne.bed $k | tee log${k}.out; 

done  