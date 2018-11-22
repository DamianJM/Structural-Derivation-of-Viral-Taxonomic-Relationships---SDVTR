#!/bin/bash

#Need to partition sequences into separate folders and name as seq.fasta

mkdir Sequences
mv *.fasta Sequences/
cd Sequences

n=1;
max=$(ls -l . | egrep -c '^-')

while [ "$n" -le "$max" ]; do mkdir "seq$n"; mv "seq$n.fasta" "seq$n"; cd "seq$n"; mv "seq$n.fasta" "seq.fasta"; cd ../; n=`expr "$n" + 1`; done

#Parameters for Running I-Tasser

n=1;

while [ "$n" -le "$max" ]; do cd "seq$n"; /media/damian/Hybrid/I-TASSER5.1/I-TASSERmod/./runI-TASSER.pl -libdir /media/damian/Hybrid/I-TASSER5.1/ITLIB/ -datadir /media/damian/Hybrid/Viral_Structural_Taxonomy/Pipeline_Isolates/Pipeline/Extracted_Sequences/Sequences/"seq$n" -runstyle gnuparallel -outdir "seq$n" -seqname seq.fasta; cd ../; n=`expr "$n" + 1`; done

#Extraction of primary models

n=1; for folder in *; do cp $folder/model1.pdb .; mv model1.pdb "$n"_model1.pdb; n=`expr "$n" + 1`; done
mkdir models
mv *_model1.pdb models
cd models/







