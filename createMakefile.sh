#!/usr/bin/bash
# criar makefile paleomix usando lista de barcode

# keys and values
id_sample=($(awk -F "," 'NR>1 {print $2}' /media/labgenoma4/DATAPART7/duda_grupo/leopardus_hybrid_zone/barcodeAssociationTable.txt))
#id_library=($(awk -F "," 'NR>1 {print $1}' /media/labgenoma4/DATAPART7/duda_grupo/leopardus_hybrid_zone/barcodeAssociationTable.txt | sed 's/FT-//g'))

file_path="/media/labgenoma4/DATAPART7/duda_grupo/leopardus_hybrid_zone"

# criando texto
echo -e "batch001:" > ~/paleomix/samples_makefile.txt

for (( i=0; i<"${#id_sample[@]}"; i++ )); do
	echo -e "  ${id_sample[i]}:\n    ${id_sample[i]}:" >> ~/paleomix/samples_makefile.txt
#	echo -e "      lane1: $file_path/FT-${id_library[i]}-FT-SPN00843_HC25WCCX2/SE6130_${id_library[i]}_S*_L006_R{Pair}_001.fastq.gz\n" >> samples_makefile.txt
#	echo -e "      lane1: $file_path/SE6130_${id_library[i]}_S*_L006_R{Pair}_001.fastq.gz\n" >> ~/paleomix/samples_makefile_v2.txt
	echo -e "      lane1: $file_path/batch001_${id_sample[i]}_R{Pair}.fastq.gz\n" >> ~/paleomix/samples_makefile.txt
done
