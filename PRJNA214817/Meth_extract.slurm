#!/usr/bin/bash
#SBATCH --job-name=Methylation_Extraction
#SBATCH --time=05:55:55
#SBATCH -p normal
#SBATCH -c 30
#SBATCH --mem=128GB

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
#rm /scratch/groups/ximenac/PRJNA208503/Bismark_Aligned/*
#rmdir /scratch/groups/ximenac/PRJNA208503/Bismark_Aligned

#Else create the directory
mkdir /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local/Meth_Extract
cd /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local

Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble

#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local/Meth_Extract
bam=/scratch/groups/ximenac/PRJNA214817/Bismark_Dedup
samtools=/share/software/user/open/samtools/1.16.1/bin/samtools

#NOTE: --bedGraph parameter was removed. Run bismark2report once methylation extractor is complete

bismark_methylation_extractor --paired-end --ignore 8 --ignore_r2 8 --ignore_3prime 8 --ignore_3prime_r2 8 --multicore 10 --no_overlap --gzip --comprehensive --samtools_path $samtools --remove_spaces --no_header --buffer_size 50G --genome_folder $Genome -o Local $bam/*bam > Meth_extract_Log 

wait

exit


