#!/bin/bash
# create a makefile from a sample-library table to run paleomix

## keys and values
if [[ $# != 4 ]]; then
	echo "Usage: createMakefile.sh dataset_name table_file fastq_path sample_makefile"
	exit 1
fi

dataset=$1
table=$2
file_path=$3
sample_makefile=$4
id_sample=($(awk -F "," 'NR>1 {print $2}' $table))
id_library=($(awk -F "," 'NR>1 {print $1}' $table | sed 's/FT-//g')) # edit this sed according to fastq file name; its use depends on the fastq file name

## criating file
cat $sample_makefile > $dataset\_makefile.txt
echo -e "$dataset:" >> $dataset\_makefile.txt

for (( i=0; i<"${#id_sample[@]}"; i++ )); do
	echo -e "  ${id_sample[i]}:\n    ${id_sample[i]}:" >> $dataset\_makefile.txt
#	echo -e "      lane1: $file_path/SE6130_${id_library[i]}_S*_L006_R{Pair}_001.fastq.gz\n" >> $dataset\_makefile.txt
	echo -e "      lane1: $file_path/$dataset\_${id_sample[i]}_R{Pair}.fastq.gz\n" >> $dataset\_makefile.txt
done
