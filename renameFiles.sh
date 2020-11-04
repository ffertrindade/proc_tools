#!/bin/bash
# rename files in diferent situations

## arguments
if [[ $# > 3 ]] || [[ $# == 0 ]]; then
        echo "Usage: renameFiles.sh bam/fastq pattern/table_file dataset_name"
	echo "<bam> add .bam at the end of the file"
	echo "<fastq> rename fastq based on a table of old and new names"
	echo "<pattern> pattern used to recognize the list of bam files"
	echo "<table> table file used to rename fastq files"
	echo "<dataset_name> name of the fastq dataset"
        exit 1
fi

option=$1

if [[ $option = "bam" ]]; then

	## add .bam at the end of the file
	if [ -z "$2" ]; then
		echo "Missing options:"
		echo "<pattern> pattern used to recognize the list of bam files"
	fi

	pat=$2
	files=($(ls -l | grep -E "$pat" | awk '{print $9}'))
	for (( i=0; i<"${#files[@]}"; i++ )); do
        	echo -e "Renaming file $PWD/${files[i]} (...)"
		mv ${files[i]} ${files[i]}.bam
	done

elif [[ $option = "fastq" ]]; then

	## rename fastq based on a table of old and new names
	if [ -z "$2" ] || [ -z "$3" ]; then
		echo "Missing options:"
		echo "<table> table file used to rename fastq files"
		echo "<dataset_name> name of the fastq dataset"
		exit 1
	fi

	table=$2
	dataset=$3

	init=($(awk -F "," 'NR>1 {print $1}' $table | sed 's/FT-//g'))
	final=($(awk -F "," 'NR>1 {print $2}' $table))
	for (( i=0; i<"${#init[@]}"; i++ )); do
        	echo -e "Renaming ${init[i]} to ${final[i]} (...)"
	        mv SE*_${init[i]}_S*_L*_R1*.fastq.gz $dataset\_${final[i]}_R1.fastq.gz
		mv SE*_${init[i]}_S*_L*_R2*.fastq.gz $dataset\_${final[i]}_R2.fastq.gz
	done

else
	echo "Choose \"bam\" OR \"fastq\":"
	echo "<bam> add .bam at the end of the file"
	echo "<fastq> rename fastq based on a table of old and new names"
	exit 1
fi
