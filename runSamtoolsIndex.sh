#!/usr/bin/bash
# gerar arquivos bai de mapeamentos

bamfiles=($(ls -l *realigned.bL* | awk '{print $9}'))

for (( i=0; i<"${#bamfiles[@]}"; i++ )); do
        echo -e "Running file ${bamfiles[i]} (...)"
	samtools index ${bamfiles[i]}
done

