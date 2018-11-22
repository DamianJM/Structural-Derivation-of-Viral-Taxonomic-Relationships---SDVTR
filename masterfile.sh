#!/usr/bin/env bash

bash blast_extraction.sh

cd Extracted_Sequences/

sed -i 's/>.*/>/g' extraction.fasta #Deletes fasta headers

python ../append_unique_headers.py extraction.fasta #Adds seq1 etc to fasta headers

cp ../I-tasser_run.sh .
perl Fasta_file_splitter.pl

rm output.fasta extraction.fasta

#I-tasser Run and extraction

bash I-tasser_run.sh

#tm-align script all vs all comparison

cd /media/damian/Hybrid/Viral_Structural_Taxonomy/Pipeline_Isolates/Pipeline/Extracted_Sequences/Sequences/models/
cp ../../../Tmalign_allvsallcomaprion.sh .
bash Tmalign_allvsallcomaprion.sh
find . -name '*.txt' -exec cat {} \; > output
mv output all.txt 

#tm-align process

python ../../../Extract_TM_results.py all.txt
sed -i '1s/^/model1,model2,score\n/' output.txt

#processing of file into distance matrix and construction of phylogenetic tree
#(Hclust and ape in R)

Rscript visualisation.R
