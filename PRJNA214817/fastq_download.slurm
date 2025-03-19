#!/usr/bin/bash
#BATCH --job-name=PRJNA214817_data_download
#SBATCH --time=02:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB

# PRJNA294311
# mkdir $GROUP_SCRATCH/PRJNA214817/
# mkdir $GROUP_SCRATCH/PRJNA214817//fastq
cd $GROUP_SCRATCH/PRJNA214817/fastq/


wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921774/SRR921774.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950179/SRR950179_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950179/SRR950179_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950176/SRR950176_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950176/SRR950176_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950169/SRR950169_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950169/SRR950169_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950173/SRR950173_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950173/SRR950173_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950177/SRR950177_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950174/SRR950174_1.fastq.gz &  
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950174/SRR950174_2.fastq.gz


wait 
