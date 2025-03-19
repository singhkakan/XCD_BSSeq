#!/usr/bin/bash
#SBATCH --job-name=Bismark_Align
#SBATCH --time=23:55:55
#SBATCH -p bigmem
#SBATCH -c 48
#SBATCH --mem=256GB

#Downloading Mouse reference genome fasta
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/GRCm39.primary_assembly.genome.fa.gz


#Downloading mouse Reference Genome GTF
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/gencode.vM36.annotation.gtf.gz

#Bismark Installation

#Downloading binaries
#cd into working directory
#wget https://github.com/FelixKrueger/Bismark/archive/refs/tags/v0.24.2.tar.gz
#chmod 755 *
#tar xzf *

#This created a folder with requisite binaries: "Bismark-0.24.2"  
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
rm /scratch/groups/ximenac/GSE134873/Bismark_Aligned/*
rmdir /scratch/groups/ximenac/GSE134873/Bismark_Aligned

#Else create the directory
#mkdir /scratch/groups/ximenac/GSE134873/Bismark_Aligned
cd /scratch/groups/ximenac/GSE134873/Bismark_Aligned

Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome
#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/GSE134873/Bismark_Aligned
fastq=/scratch/groups/ximenac/GSE134873

#for i in {2..4}
#do
bismark --gzip --multicore 8 -p 2 --genome_folder $Genome --local --path_to_bowtie $path_to_bowtie2 --Output_dir $output -q -1 $fastq/3M/SRR9833664_1_val_1_val_1.fq.gz -2 $fastq/3M/SRR9833664_2_val_2_val_2.fq.gz
#done 

wait

exit
