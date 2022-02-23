#!/usr/bin/python3.6
### Remove all Ns from a aligned fasta file
### The percent indicate how much missing are allowed per site
### Fernanda Trindade, 02-22-2022

## Import
from Bio import SeqIO
import sys
import re

## Prepare arguments
#my_args = sys.argv
my_args = ['./removeNs.py','examples/TESTE.fasta','91']
if len(my_args) < 3:
    print("Usage: removeNsAligned.py aligned.fasta percent")
    exit()
else:
    input = list(SeqIO.parse(my_args[1], "fasta"))
    output = open(re.sub('.fasta', '.' + my_args[2] + 'N.fasta', my_args[1]), "w")
    perc = int(my_args[2])

## Puting the sequences in a list of lists and creating a final empty list to receive the filtered data
ind = 0
for i in range(len(input)):
    ind+=1

seq = []
for i in range(ind) :
    seq.append(input[i].seq)

final_seq = [ []*len(seq[0]) for ind in range(ind) ]

## Checking the conditions to remove the site
columnIndex = 0
indexToRemove = []

while columnIndex < len(seq[0]) :

    CountN = 0
    for i in range(ind):
        if seq[i][columnIndex] == "N":
            CountN+=1
    
    if (CountN/ind)*100 >= perc:
        indexToRemove.append("1")
    else:
        indexToRemove.append("0")
    
    columnIndex+=1

## Checking each position and writing to the final list
for i in range(ind):

    columnIndex = 0
    while columnIndex < len(indexToRemove) :
        if indexToRemove[columnIndex] == "0":
            final_seq[i].append(seq[i][columnIndex])

        columnIndex+=1

for i in range(ind) :
	string = str(''.join(final_seq[i]))
	output.write('>' + input[i].id + '\n' + string + '\n')

output.close()