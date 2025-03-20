#!/usr/bin/bash
#SBATCH --job-name=RefBuild_bismark
#SBATCH --time=8:00:00
#SBATCH -p bigmem
#SBATCH -c 40
#SBATCH --mem=256GB

#GENOME ASSEMBLY WITH PATCHES
#Downloading Mouse reference genome fasta
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/GRCm39.primary_assembly.genome.fa.gz
#Downloading mouse Reference Genome GTF
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/gencode.vM36.annotation.gtf.gz

#GENOME ASSEMBLY WITHOUT PATCHES (Gencode Release M36: Basic gene annotation CHR)
#mkdir /home/groups/ximenac/GSE134873/mouse_genome_no_patches
#cd /home/groups/ximenac/GSE134873/mouse_genome_no_patches
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/gencode.vM36.basic.annotation.gtf.gz
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/GRCm39.genome.fa.gz
#wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/GRCm39.primary_assembly.genome.fa.gz

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

#Building Bismark reference genome
index=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensembl
Genome_fa=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches
#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/

#bismark_genome_preparation --bowtie2 --parallel 8 --genomic_composition --path_to_aligner $path_to_bowtie2 --verbose $Genome_fa &


#####Ensmbl Genomes#####
#mkdir /home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble
cd /home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble

Genome=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Ensmble

bismark_genome_preparation --bowtie2 --parallel 8 --genomic_composition --path_to_aligner $path_to_bowtie2 --verbose $Genome

wait
