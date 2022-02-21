#!/usr/bin/python3.6
### Remove all Ns from fasta sequences
### Fernanda Trindade, 02-18-2022

## Import
from Bio import SeqIO
import sys
import re

## Prepare arguments
my_args = sys.argv
#my_args = ['./removeNs.py','examples/TESTE.fasta']
if len(my_args) == 0 or len(my_args) < 2:
    print("Usage: removeNs.py input.fasta")
    exit()
else:
    input = list(SeqIO.parse(my_args[1], "fasta"))
    output = open(re.sub('.fasta', '.noN.fasta', my_args[1]), "w")

## Puting the sequences in a list of lists and creating a final empty list to receive the filtered data
ind = 0
for i in range(len(input)):
    ind+=1

seq = []
for i in range(ind) :
    seq.append(input[i].seq)

final_seq = [ []*len(seq[0]) for ind in range(ind) ]

## Checking each base and writing to the final list
for i in range(ind):
    columnIndex = 0
    while columnIndex < len(seq[0]) :
        if seq[i][columnIndex] == "N":
            columnIndex+=1
        else :
            final_seq[i].append(seq[i][columnIndex])
            columnIndex+=1

for i in range(ind) :
	string = str(''.join(final_seq[i]))
	output.write('>' + input[i].id + '\n' + string + '\n')

output.close()


