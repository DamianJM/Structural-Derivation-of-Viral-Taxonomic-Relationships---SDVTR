#Append unique headers to FASTA

import argparse, sys

try:
	parser = argparse.ArgumentParser()
	parser.add_argument("file", help="Input multifasta file",
                type=str)
	args = parser.parse_args()

	filename = args.file

except:
	e = sys.exc_info()[0]
	print e

with open(filename, "r") as fasta:
	fasta = fasta.read()

postfixint = 1
postfix = "seq"

postfinal = postfix + str(postfixint)

sequence = []
sequence2 = []

for i in fasta:
	sequence += i

for i, item in enumerate(sequence):
	if item == ">":
		sequence2 += item
		sequence2 += postfinal
		postfixint += 1
		postfinal = postfix + str(postfixint)
	else:
		sequence2 += item



output = open("output.fasta", "w")

for i in sequence2:
	output.write(i)

file.close(output)
	



