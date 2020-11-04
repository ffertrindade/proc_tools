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
samtools saplit -@$p -f"%*.%!" $dir/$ds/$ds.$ref.realigned.bam
