#!/usr/bin/bash
#SBATCH --job-name=Dedup_Bismark
#SBATCH --time=12:55:55
#SBATCH -p normal
#SBATCH -c 4
#SBATCH --mem=64GB
#SBATCH --ntasks=2

#Ensuring Bismark is in path
export PATH="$PATH:/home/groups/ximenac/XCD_BSSeq/GSE134873/Bismark-0.24.2"
#Building Bismark reference genome

#Load Dependencies
module load devel
module load perl/5.36.1
module load biology
module load bowtie2/2.3.4.1
module load samtools/1.16.1

#If directory exists
#rm /scratch/groups/ximenac/PRJNA541237/Bismark_Aligned/*
#rmdir /scratch/groups/ximenac/PRJNA541237/Bismark_Aligned

#Else create the directory
mkdir /scratch/groups/ximenac/PRJNA541237/Bismark_Aligned/Local/Bismark_Dedup
cd /scratch/groups/ximenac/PRJNA541237/Bismark_Aligned/Local/Bismark_Dedup

Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble

#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/PRJNA541237/Bismark_Aligned/Local/Bismark_Dedup
bam=/scratch/groups/ximenac/PRJNA541237/Bismark_Aligned/Local
samtools=/share/software/user/open/samtools/1.16.1/bin/samtools

deduplicate_bismark --paired --output_dir $Output --samtools_path $samtools --bam $bam/*bam &

wait

exit


