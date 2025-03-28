#!/usr/bin/bash
#SBATCH --job-name=BedGraph
#SBATCH --time=15:55:55
#SBATCH -p normal
#SBATCH -c 2
#SBATCH --mem=20GB
#SBATCH --ntasks=7

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
bam=/scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/Local/Meth_Extract
samtools=/share/software/user/open/samtools/1.16.1/bin/samtools

#NOTE: --bedGraph parameter was removed. Run bismark2report once methylation extractor is complete

for i in {3..9}
do
    #if CpG or CHG or CHH in item
    bismark2bedGraph --ucsc --remove_spaces --buffer_size 100G --CX_context --ucsc -o SRR95017${i}bedgraph.gz --dir $Output $bam/*context_SRR95017$i*gz &
done

#bismark2bedGraph --buffer_size 100G --CX_context --ucsc -o SRR950180_bedgraph.gz --dir $Output $bam/*context_SRR950180*gz

wait

coverage2cytosine --genome_folder $Genome --CX_context --merge_CpG -o SRR950180_cytosine report --dir $Output $bam/SRR950180_bedgraph.gz.bismark.cov.gz

exit


