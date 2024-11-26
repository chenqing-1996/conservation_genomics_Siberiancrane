#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-roh-%j.out
#SBATCH --error=slurm-roh-%j.err

plink --bfile path/to/SC.plinkbed  --homozyg --homozyg-window-snp 100 --homozyg-snp 50 --homozyg-window-missing 1 --homozyg-kb 100 --allow-no-sex --allow-extra-chr