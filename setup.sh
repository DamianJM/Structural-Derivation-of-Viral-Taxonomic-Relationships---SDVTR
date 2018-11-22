#!/bin/bash

#Simple and Optional Script to setup acquisition of viral genomes and their annotation 

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/viral/assembly_summary.txt
awk -F '\t' '{if($12=="Complete Genome") print $20}' assembly_summary.txt > assembly_summary_complete_genomes.txt
mkdir GbVir
for next in $(cat assembly_summary_complete_genomes.txt); do wget -P GbVir "$next"/*genomic.fna.gz; done
gunzip GbVir/*.gz
cat GbVir/*.fna > all_complete_Gb_vir.fasta

#annotation with prodigal and production of BLAST Database

prodigal -i all_complete_Gb_vir.fasta -a multifasta.fasta

makeblastdb -in viral_proteins.fasta -input_type fasta -dbtype prot -title viraldb -out viraldb
mkdir Database
mv *viraldb* Database







