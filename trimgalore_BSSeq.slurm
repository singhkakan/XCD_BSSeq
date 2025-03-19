#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:55:59
#SBATCH --mem=256GB
#SBATCH -c 2
#SBATCH --ntasks=10


module load biology
# Because version 0.5.0 of trim_galore does not support multi-core functionality, we will manually load the most recent version as of today (Feb 20th, 2025)
#module load trim_galore/0.5.0

module load devel
module load python/3.6.1
module load py-cutadapt/1.18_py36
module load fastqc/0.11.8
module load system
# This module loads pigz: A parallel implementation of gzip for modern multi-processor, multi-core machines 2.4. This should speed up the running of trim_galore v0.6
module load contribs 
module load poldrack
module load pigz/2.4

#ALways double check your quotes when copy-pasting
export PATH="$PATH://home/groups/ximenac/XCD_BSSeq/GSE134873/TrimGalore-0.6.10"

for dir in /scratch/groups/ximenac/*
do  
    rm trimgalor/*
    rmdir trimgalor
    mkdir $dir/trimgalore_1
done

#Create a list of directories with paired end reads
declare -a paired_end
paired_end=([0]="PRJNA214817" [1]="PRJNA343691" [2]="PRJNA521997" [3]= "PRJNA541237")

#Create a list of directories with single end reads
declare -a single_end
single_end=([0]="PRJNA208503" [1]="PRJNA294311")

#PRJNA208503 #single
#PRJNA214817 #paired
#PRJNA294311 #single
#PRJNA343691 #paired
#PRJNA521997 #paired
#PRJNA541237 #paired


for dir in /scratch/groups/ximenac/*
do
    fastq=$dir/fastq
    for item in "${paired_end[@]}"
    do
        if [[ "$dir" != "${dir/$item}" ]] ; then
            cd $dir/trimgalore_1
            trim_galore -q 25 --a " AGATCGGAAGAGCGT -a ACACGTCTGAAC -a GTAGGGAAAGAGTG" --phred33 --paired --fastqc --length 15 --max_n 10 --cores 2 -o $dir/trimgalore_1/ $fastq/*1.fastq.gz $fastq/*2.fastq.gz &
        fi
    done
    for item in "${single_end[@]}"
    do
        if [[ "$dir" != "${dir/$item}" ]] ; then
            cd $dir/trimgalore_1
            trim_galore -q 25 --a " AGATCGGAAGAGCGT -a ACACGTCTGAAC -a GTAGGGAAAGAGTG" --phred33 --fastqc --length 20 --max_n 20 --cores 4 -o $dir/trimgalore_1/ $fastq/*gz &
            wait
        fi
    done
done


wait

exit
