#!/bin/bash
#SBATCH -p mars
#SBATCH -c 8
#SBATCH --mem=24G
#SBATCH --output=slurm-psmc-%j.out
#SBATCH --error=slurm-psmc-%j.err

echo ==========selectSNP starts at `date`==========

##get high-depth sample vcf file
bcftools mpileup -Q 20 -f path/to/ref.fasta path/to//bam/SC01W.sort.deduped.bam | bcftools call -c > path/to/SC01W.vcf
## get fasta file
perl vcfutils.pl vcf2fq path/to/SC01W.vcf > path/to/SC01W.fq
##remove sex chromosome
python delete_fqsexchr.py
##get psmcfa
path/to/psmc-master/utils/fq2psmcfa -q20 path/to/SC01W_withoutsexchr.fq.gz > path/to/SC01W.psmcfa
##get psmc input
path/to/psmc-master/psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o SC01W.psmc SC01W.psmcfa
##plot
perl path/to/psmc-master/utils/psmc_plot.pl -u 4.9e-09 -g 3.5 SC01W.psmc
##bootstrap 100
path/to/psmc-master/utils/splitfa path/to/SC01W.psmcfa > path/to/SC01W.split.psmcfa
seq 100 | xargs -i echo  path/to/psmc-master/psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" -o path/to/round-{}.psmc path/to/SC01W.split.psmcfa | sh
cat path/to/SC01W.psmc path/to/round-*.psmc > SCWcombined.psmc
perl path/to/psmc-master/utils/psmc_plot.pl -u 4.9e-09 -g 3.5 combined SCWcombined.psmc

echo ==========selectSNP ends at `date`==========