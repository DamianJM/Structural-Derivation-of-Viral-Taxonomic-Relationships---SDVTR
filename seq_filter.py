#Sequence_Filter - Removes Sequences of certain length compared to query

import sys

queryseq = ""
with open("input.fasta", "r") as query:
	query = ""
	for line in query:
		if line.startswith('>'):
			queryseq += query
			query = ''
		else:
			query += line.strip()

sequences = []

try:
	parser = argparse.ArgumentParser()
	parser.add_argument("file", help="Sequence Length Filter",
                type=str)
	args = parser.parse_args()

	filename = args.file

except:
	e = sys.exc_info()[0]
	print e

with open(filename, 'r') as final:
    sequence = ''
    for line in final:
        if line.startswith('>'):
            sequences.append(sequence)
            sequence = ''
        else:
            sequence += line.strip()

lenfilter = len(queryseq)
newseq = []

for i in sequences:
	if len(i) < (lenfilter/1.5):
		pass
	else:
		newseq.append(i)


outputfile = open(output.txt, "w")
count = 0

for j in newseq:
	count += 1
	outputfile.write(">")
	outputfile.write(count)
	outputfile.write("\n")
	outputfile.write(j)

outputfile.close()
