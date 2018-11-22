#Extract TM_Align Results
#Extracts name of compared protein and average tmalign score
#Damian Magill 2018

#Importing required modules

import argparse, sys

#Inputting and parsing file

try:
	parser = argparse.ArgumentParser()
	parser.add_argument("file", help="Parsing TM-Align output files",
                type=str)
	args = parser.parse_args()

	filename = args.file

except:
	e = sys.exc_info()[0]
	print e

#Extraction of specific lines from input file into separate lists containing chain names and TM-values

with open(filename,'r') as f:
	comparison_model = [line for line in f if "Name of Chain_1" in line]

with open(filename,'r') as g:
	tm_align = [line for line in g if "average length of chains" in line]

with open(filename,'r') as h:
	reference_model = [line for line in h if "Name of Chain_2" in line]


#Removal of unneccessary strings


comparisonextract = [x.replace("Name of Chain_1:", "") for x in comparison_model]
comparisonextract2 = [y.replace("\n", "") for y in comparisonextract]
comparisonextract3 = [z.replace(" ", "") for z in comparisonextract2]

referenceextract = [x.replace("Name of Chain_2:", "") for x in reference_model]
referenceextract2 = [y.replace("\n", "") for y in referenceextract]
referenceextract3 = [z.replace(" ", "") for z in referenceextract2]


sep = '('
tmextract1 = [i.split(sep, 1)[0] for i in tm_align]
tmextract2 = [j.replace("TM-score=", "") for j in tmextract1]

#Production of equivalent list indices for extraction of equivalent information

com_ref = []


for i in comparisonextract3:
	com_ref.append(i)

referenceinsertionindex = []


count = -1	
for i in referenceextract3:
	count += 2
	com_ref.insert(count, i)

count2 = -1
for i in tmextract2:
	count2 += 3
	com_ref.insert(count2, i)

final_list1 = []
extractindex = 0
for i in com_ref:
	final_list1.append(com_ref[extractindex:extractindex+3])
	extractindex += 3

finallist_complete = []
for i in final_list1:
	if i == []:
		pass
	else:
		finallist_complete.append(i)
	
	
for i in finallist_complete:
	i.insert(1, ",")

for i in finallist_complete:
	i.insert(3, ",")

#Writing to output file

outputfile = open("output.txt", "w")

output_temp_string = ""
for output in finallist_complete:
	for element in output:
		output_temp_string += element
	outputfile.write(output_temp_string)
	outputfile.write("\n")
	output_temp_string = ""

outputfile.close()
		








