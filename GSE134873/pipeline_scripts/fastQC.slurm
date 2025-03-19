



fastq_dir=$GROUP_SCRATCH/*/fastq
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
#       filename=$(echo $file | grep -oP 'SRR.*?\.')
#       echo $filename
#       fastqc -t 4 -o $fastqc_out_dir $file
#done

