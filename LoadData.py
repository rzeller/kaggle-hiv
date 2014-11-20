import csv

data=[]
with open('training_data.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile, delimiter=',')
	reader.next()
	for row in reader:
		data.append((int(row[0]),int(row[1]),row[2],row[3],float(row[4]),int(row[5])))

protease=[]
for d in data:
	protease.append(d[3])



codonDict={'TTT':'F','TTC':'F',
	'TTA':'L','TTG':'L','CTT':'L','CTC':'L','CTA':'L','CTG':'L',
	'ATT':'I','ATC':'I','ATA':'I',
	'ATG':'M',
	'GTT':'V','GTC':'V','GTA':'V','GTG':'V',
	'TCT':'S','TCC':'S','TCA':'S','TCG':'S',
	'CCT':'P','CCC':'P','CCA':'P','CCG':'P',
	'ACT':'T','ACC':'T','ACA':'T','ACG':'T',
	'GCT':'A','GCC':'A','GCA':'A','GCG':'A',
	'TAT':'Y','TAC':'Y',
	'TAA':'*','TAG':'*',
	'CAT':'H','CAC':'H',
	'CAA':'Q','CAG':'Q',
	'AAT':'N','AAC':'N',
	'AAA':'K','AAG':'K',
	'GAT':'D','GAC':'D',
	'GAA':'E','GAG':'E',
	'TGT':'C','TGC':'C',
	'TGA':'*',
	'TGG':'W',
	'CGT':'R','CGC':'R','CGA':'R','CGG':'R',
	'AGT':'S','AGC':'S',
	'AGA':'R','AGG':'R',
	'GGT':'G','GGC':'G','GGA':'G','GGG':'G'}
	# 'GCN':'A',
	# 'CGN':'R','MGR':'R',
	# 'AAY':'N',
	# 'GAY':'D',
	# 'TGY':'C',
	# 'CAR':'Q',
	# 'GAR':'E',
	# 'GGN':'G',
	# 'CAY':'H',
	# 'ATH':'I',
	# 'YTR':'L','CTN':'L',
	# 'AAR':'K',
	# 'TTY':'F',
	# 'CCN':'P',
	# 'TCN':'S','AGY':'S',
	# 'ACN':'T',
	# 'TAY':'Y',
	# 'GTN':'V',
	# 'TAR':'X','TRA':'X',
	# 'YTA':'L',
	# 'GCW':'A',
	# 'CGM':'R',
	# 'CCM':'P',
	# 'TTR':'L',
	# 'KCA':'-',
	# 'ARG':'-',
	# 'WTA':'-',
	# 'YAT':'-'}

ambiguity = {'K':['G','T'],
	'M':['A','C'],
	'R':['A','G'],
	'Y':['C','T'],
	'S':['C','G'],
	'W':['A','T'],
	'B':['C','G','T'],
	'V':['A','C','G'],
	'H':['A','C','T'],
	'D':['A','G','T'],
	'N':['G','A','C','T']}

def translate(nucStr,codonDict,ambiguity):
	aaStr=''
	for ic in range(len(pro)/3):
		codon=pro[3*j:3*(j+1)]
		if codon in codonDict:
			aaStr=codonDict[codon]
		else:
			#for each ambiguous nucleotide
			#create new codon possibilities
			#if all codon possiblities are the same, it's that aa
			#else, no idea








aas=[]
for i,pro in enumerate(protease):
	aas.append('')
	for j in range(len(pro)/3):
		if pro[3*j:3*(j+1)] in codon:
			aas[i]+=codon[pro[3*j:3*(j+1)]]
		else:
			aas[i]+='-'

for aasi in aas:
	print aasi



