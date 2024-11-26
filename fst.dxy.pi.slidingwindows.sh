#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-genomiclanscap-%j.out
#SBATCH --error=slurm-genomiclanscap-%j.err

echo ==========selectSNP starts at `date`==========

python path/to/genomics_general-master/VCF_processing/parseVCF.py -i  path/to/SC_withoutsexcontig.vcf | bgzip >  path/to/SC.geno.gz
python path/to/genomics_general-master/popgenWindows.py -g  path/to/SC.geno.gz -o  path/to/SC_50Kbwindows.Dxy.pi.fst.csv -f phased -w 50000 -m 10 -p SCW SC01W,SC02W,SC03W,SC04W,SC05W -p SCA sample_SC02A,sample_SC03A,sample_SC04A,sample_SC05A,sample_SC06A,sample_SC07A,sample_SC08A,SC09A,SC10A,SC11A,SC12A,SC13A -T 5 --windType coordinate

echo ==========selectSNP ends at `date`==========