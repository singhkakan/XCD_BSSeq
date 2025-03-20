#!/usr/bin/bash
#SBATCH --job-name=TrimGalore_3
#SBATCH --time=5:00:00
#SBATCH -p bigmem
#SBATCH -c 6
#SBATCH --mem=256GB
#SBATCH --ntasks=3


module load devel
module load python/3.6.1

module load biology
module load py-cutadapt/1.18_py36
module load fastqc/0.11.8
module load system

# This module loads pigz: A parallel implementation of gzip for modern multi-processor, multi-core machines 2.4. This should speed up the running of trim_galore v 0.6.0
module load contribs 
module load poldrack
module load pigz/2.4

export PATH="$PATH:/home/groups/ximenac/GSE134873/TrimGalore-0.6.10"
fastq_dir=/scratch/groups/ximenac/GSE134873/fastq
trim_galore_out=/scratch/groups/ximenac/GSE134873/trim_galore_out


for i in {2..4}
do 
	trim_galore -q 20 --phred33 --paired --fastqc --length 15 --trim-n --clip_R1 10 --clip_R2 20 --three_prime_clip_R1 10 --three_prime_clip_R2 15 --cores 4 -o $trim_galore_out $fastq_dir/SRR983366[$i]_*.fastq.gz &
done

#for i in {3..9}
#do 
#        trim_galore -q 20 --illumina --adapter2 A{10} --phred33 --paired --fastqc --length 10 --trim-n --clip_R1 8 --clip_R2 16 --three_prime_clip_R1 10 --three_prime_clip_R2 5 --cores 4 -o $trim_galore_out $fastq_dir/SRR983366[$i]_*.fastq.gz &
#done

wait


