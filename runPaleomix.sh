#!/bin/bash
# Run Paleomix for several samples at once and samtools to split them

## arguments
if [[ $# != 5 ]]; then
        echo "Usage: runPaleomix.sh run_dir makefile dataset_name ref_name threads"
	echo "<run_dir> path where Paleomix should run"
	echo "<makefile> makefile"
	echo "<dataset_name> target name from Paleomix makefile"
	echo "<ref_name> reference name from Paleomix makefile"
	echo "<threads> number of threads to be used"
        exit 1
fi

dir=$1
mf=$2
ds=$3
ref=$4
p=$5

## Running Palemix
bam_pipeline run --jre-option "-Xmx60g" --max-threads $p --bwa-max-threads $p --adapterremoval-max-threads $p --destination $dir $mf

## Spliting bam file per sample RG
cd $dir/$ds
samtools saplit -@$p -f"%*.%!" $ds.$ref.realigned.bam
renameFiles.sh bam $ds.$ref.realigned

## Creating index for all bam files
bamfiles=($(ls -l $ds.$ref.realigned.*.bam | awk '{print $9}'))

for (( i=0; i<"${#bamfiles[@]}"; i++ )); do
        echo -e "Indexing file ${bamfiles[i]} (...)"
        samtools index ${bamfiles[i]}
done
