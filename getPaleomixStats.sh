#!/usr/bin/bash
# pegar varios stats de depth e coverage dos arquivos do paleomix para diversas amostras

# arquivos
samples=~/paleomix/batch001/samples.txt
summary_paleomix=~/paleomix/batch001/batch001.summary
depths_paleomix=~/paleomix/batch001/batch001.felCat9.depths
output=~/paleomix/batch001/batch001_paleomix

# reads summary
echo "sample,seq_reads_pairs,seq_collapsed,seq_retained_reads,seq_retained_length,seq_retained_nts,hits_raw,hits_raw_frac,hits_unique,hits_unique_frac,hits_depth,max_depth,ref_cov" > $output\_readsSummary.csv
for i in $(cat $samples); do
	echo -e "Checking sample $i..."
	seq_reads_pairs=$(awk '$4 == "seq_reads_pairs" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
        seq_collapsed=$(awk '$4 == "seq_collapsed" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	seq_retained_reads=$(awk '$4 == "seq_retained_reads" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	seq_retained_length=$(awk '$4 == "seq_retained_length" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	seq_retained_nts=$(awk '$4 == "seq_retained_nts" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	hits_raw=$(awk '$4 == "hits_raw(felCat9)" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	hits_raw_frac=$(awk '$4 == "hits_raw_frac(felCat9)" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	hits_unique=$(awk '$4 == "hits_unique(felCat9)" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	hits_unique_frac=$(awk '$4 == "hits_unique_frac(felCat9)" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	hits_coverage=$(awk '$4 == "hits_coverage(felCat9)" {print $0}' $summary_paleomix | awk -v i="$i" '$3 == i {print $5}')
	max_depth=$(awk '$4 == "*" {print $0}' $depths_paleomix | awk -v i="$i" '$3 == i {print $6}')
	ref_cov=$(awk '$4 == "*" {print $0}' $depths_paleomix | awk -v i="$i" '$3 == i {print $7}')

	echo $i,$seq_reads_pairs,$seq_collapsed,$seq_retained_reads,$seq_retained_length,$seq_retained_nts,$hits_raw,$hits_raw_frac,$hits_unique,$hits_unique_frac,$hits_coverage,$max_depth,$ref_cov >> $output\_readsSummary.csv
done

# cromosome summary
echo "Sample,Contig,MaxDepth,MD_001,MD_002,MD_003,MD_004,MD_005,MD_006,MD_007,MD_008,MD_009,MD_010"  > $output\_cromosomeSummary.csv
grep Chr $depths_paleomix | grep -Ff $samples | awk '{print $3","$4","$6","$7","$8","$9","$10","$11","$12","$13","$14","$15","$16}' >> $output\_cromosomeSummary.csv
