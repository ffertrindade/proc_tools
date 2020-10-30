#!/usr/bin/bash
# rodar samtools depth para vários bams independentes
# separar em cromossomo

bam_list=($(ls -l ~/paleomix/batch001-noMT/batch001-noMT.felCat9-masked-noMT.realigned.bL*.bam | awk -F "/" '{print $8}'))

for (( i=0; i<"${#bam_list[@]}"; i++ )); do
	echo -e "Running file $i (...)"
	samtools depth -a --reference /home/labgenoma4/duda_grupo/references/felCat9-masked.fasta ${bam_list[i]} > ${bam_list[i]}.depth
done

# rodar essa parte para cada cromossomo
for (( i=0; i<"${#bam_list[@]}"; i++ )); do
	echo -e "Greping file $i (...)"
	grep NC_018723 ${bam_list[i]}.depth | sed 's/NC_018723.3/ChrA1/g' > ChrA1depth/${bam_list[i]}.ChrA1depth
done
