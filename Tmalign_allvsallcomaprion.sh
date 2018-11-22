#!/bin/bash

mkdir Used
for file1 in *.pdb;
do
s1="$file1"
f1=$(basename $file1)
	for file2 in *.pdb;
	do
	s2="$file2"
	f2=$(basename $file2)
	TMalign $s2 $s1 -a -o "$f1"_"$f2"_TM.sup > "$f1"_"$f2".txt;
	done;
mkdir "$f1"_model1_Comparison_Results
mv *.txt "$f1"_model1_Comparison_Results/
mv $file1 Used/

done
