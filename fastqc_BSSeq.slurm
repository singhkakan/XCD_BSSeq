#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:00:00
#SBATCH --mem=256GB
#SBATCH -c 1
#SBATCH --ntasks=12


module load biology
module load fastqc/0.11.8

for dir in /scratch/groups/ximenac/*
do 
    mkdir $dir/fastqc
done


for dir in /scratch/groups/ximenac/*
do 
    cd $dir/fastqc/
    fastqc -t 16 -o $dir/fastqc $dir/fastq/*gz
done


wait
