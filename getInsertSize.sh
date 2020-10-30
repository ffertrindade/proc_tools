#!/usr/bash
# rodar picard para pegar insert size de arquivos bam

# variaveis e arquivos
bam_list=($(ls -l ~/paleomix/batch001/batch001.felCat9.realigned.bL*.bam | awk -F "/" '{print $8}'))
output_names=($(ls -l ~/paleomix/batch001/batch001.felCat9.realigned.bL*.bam | awk -F "." '{print $4}'))
output_dir=~/paleomix/batch001/insert_size

# rodar picar e gerar arquivo de saida
echo -e "sample;mean;median" > $output_dir/batch001.insertsize.csv

for (( i=0; i<"${#bam_list[@]}"; i++ )); do
        echo -e "Running file $i (...)"
#	java -jar /home/labgenoma4/programs/jar_root/picard.jar CollectInsertSizeMetrics I=${bam_list[i]} O=$output_dir/${output_names[i]}.insertSize H=$output_dir/${output_names[i]}.insertSize.pdf
	mean=$(awk 'NR==8 {print $6}' $output_dir/${output_names[i]}.insertSize)
	median=$(awk 'NR==8 {print $1}' $output_dir/${output_names[i]}.insertSize)
	echo -e "${output_names[i]};$mean;$median" >> $output_dir/batch001.insertsize.csv
done

