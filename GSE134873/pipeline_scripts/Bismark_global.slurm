#!/usr/bin/bash
#SBATCH --job-name=Bismark_Align
#SBATCH --time=4:55:55
#SBATCH -p bigmem
#SBATCH -c 48
#SBATCH --mem=256GB

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
#rm /scratch/groups/ximenac/GSE134873/Bismark_Aligned/*
#rmdir /scratch/groups/ximenac/GSE134873/Bismark_Aligned

#Else create the directory
mkdir /scratch/groups/ximenac/GSE134873/Bismark_Aligned/Global
cd /scratch/groups/ximenac/GSE134873/Bismark_Aligned/Global

Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble
#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/GSE134873/Bismark_Aligned/Global
fastq=/scratch/groups/ximenac/GSE134873/3M

bismark --gzip --multicore 8 -p 2 --genome_folder $Genome --path_to_bowtie $path_to_bowtie2 --Output_dir $Output -q -1 $fastq/SRR9833664_1_val_1_val_1.fq.gz -2 $fastq/SRR9833664_2_val_2_val_2.fq.gz

wait

exit
