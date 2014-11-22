import csv
from Bio.Seq import Seq
import MatrixRep
from MatFeatExtract import *


database='/Users/Robby/Documents/Factor14/Sequence-Databases/databases/uniprot_sprot.fasta'

data=[]
with open('training_data.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile, delimiter=',')
	reader.next()
	for row in reader:
		data.append((int(row[0]),int(row[1]),row[2],row[3],float(row[4]),int(row[5])))

#Run through data, create representations, extract features, and aggregate
for d in data[:3]:
	#Load and translate data
	protease=Seq(d[3])
	proaas=protease.translate()
	
	#Create a representation of the protein
	output=MatrixRep.PSSM(proaas.tostring(),database=database)
	mat=output['PSSM Values'].astype(float)
	
	## Run a feature extraction method on mat
	feature=PseudoPSSM(mat)

	## Aggregate Features
	if 'features' not in locals():
		features=feature.copy()
	else:
		features=np.vstack((features,feature))



#Do Machine Learning

