#!/usr/bin/bash
#SBATCH --job-name=Bismark_Align
#SBATCH --time=23:55:55
#SBATCH -p bigmem
#SBATCH -c 30
#SBATCH --mem=256GB
#SBATCH --ntasks=3

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
mkdir /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned
mkdir /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local
cd /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local
Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble

#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Global
fastq=/scratch/groups/ximenac/PRJNA214817/fastq

for i in {0..9}
do
    bismark --gzip --multicore 6 -p 2 --genome_folder $Genome --local --path_to_bowtie $path_to_bowtie2 --Output_dir $Output -q -1 $fastq/SRR9501[7-8][$i]_1.fastq.gz -2 $fastq/SRR9501[7-8][$i]_2.fastq.gz &
done 

wait

exit


