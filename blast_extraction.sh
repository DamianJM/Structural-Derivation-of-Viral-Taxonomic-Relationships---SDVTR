#!/usr/bin/env bash

#Performs BLAST search with input sequence and extracts outputs to multifasta file

blastp -db Database/viraldb -query input.fasta -out blast_results -outfmt 6 -evalue 1E-50 -num_threads 8

cut -f 2 blast_results > headers.txt

awk '!seen[$0]++' headers.txt > headers2.txt
grep -vE "trna" headers2.txt > headersfinal.txt

IFS=$'\n'; for i in $(cat headersfinal.txt);do  line=$(grep -nr "$i" multifasta.fasta); if [[ ! -z $line ]];then for j in $line;do lineNumber=$(echo $j | cut -d':' -f1); sed -n "$lineNumber p" multifasta.fasta; awk -v nb=$lineNumber 'NR > nb {if ($0 ~ ">") exit; else print $0 }' multifasta.fasta; done;fi;done > extraction.fasta

rm headers*
mkdir Extracted_Sequences
mv extraction.fasta Extracted_Sequences
cp Fasta_file_splitter.pl Extracted_Sequences




