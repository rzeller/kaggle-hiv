import csv
from Bio.Seq import Seq

data=[]
with open('training_data.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile, delimiter=',')
	reader.next()
	for row in reader:
		data.append((int(row[0]),int(row[1]),row[2],row[3],float(row[4]),int(row[5])))

protease=[]
for d in data:
	protease.append(Seq(d[3]))

for proi in protease:
	print proi.translate()



