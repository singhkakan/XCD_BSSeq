#!/usr/bin/bash

echo "########## GSE134873 WG BiSuphite Seq Analysis Pipeline ###########"

###############1. Raw Data Download ############

cd //home/groups/ximenac/GSE134873 
chmod 755 ENA_fastq_download.sh

#./pipeline_scripts/ENA_fastq_download.sh

#Data was moved from home directory to $GROUP_SCRATCH

#To view this folder

cd $GROUP_SCRATCH/GSE134873/fastq/ ; ls -lh

fastq_dir=$GROUP_SCRATCH/GSE134873/fastq

echo "raw data fastqc files are stored in: " $fastq_dir 
echo " "
ls -lh $fastq_dir

##############2. Running Quality assessment ##########

#FASTQC was used to assess the quality of the raw data

fastqc_out_dir=$GROUP_HOME/GSE134873/fastqc_out

module load biology
module load fastqc/0.11.8

fastqc -o $fastqc_out_dir -t 6 $fastq_dir/*.gz

#for file in "$fastq_dir"/*.gz
#do 
	#echo "$file"
#	filename=$(echo $file | grep -oP 'SRR.*?\.')
#	echo $filename
#	fastqc -t 4 -o $fastqc_out_dir $file
#done


############## 3. Adapter and Quality Trimming with Trimgalore ############

sbatch <<EOT
#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:00:00
#SBATCH --mem=256GB
#SBATCH -c 4
#SBATCH --ntasks=5

module purge

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

for i in {5..9}
do 
        trim_galore -q 25 --illumina --adapter2 A{10} --phred33 --paired --fastqc --length 15 --cores 4 -o $trim_galore_out $fastq_dir/SRR983366[$i]_*.fastq.gz &
done

wait

EOT
