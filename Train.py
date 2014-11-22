import csv
from Bio.Seq import Seq
import MatrixRep
from MatFeatExtract import *
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn import cross_validation
from random import shuffle
from sklearn.preprocessing import StandardScaler

database='databases/uniprot_sprot.fasta'

data=[]
with open('training_data.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile, delimiter=',')
	reader.next()
	for row in reader:
		data.append((int(row[0]),int(row[1]),row[2],row[3],float(row[4]),int(row[5])))

shuffle(data)	

#Run through data, create representations, extract features, and aggregate
for d in data:
	#Load and translate data
	protease=Seq(d[2])
	RT = Seq(d[3])
	RTaas = RT.translate()
	proaas=protease.translate()
	
	#Create a representation of the protein
	#PROoutput=MatrixRep.PSSM(proaas.tostring(),database=database)
	#RToutput=MatrixRep.PSSM(RTaas.tostring(),database=database)

	PROoutput=MatrixRep.SMR(proaas.tostring())
	RToutput=MatrixRep.SMR(RTaas.tostring())

	PROmat=PROoutput['SMR'].astype(float)
	RTmat=RToutput['SMR'].astype(float)


	## Run a feature extraction method on mat
	RTfeature=PseudoPSSM(RTmat)
	PROfeature=PseudoPSSM(RTmat)


	## Aggregate Features
	if 'RTfeatures' not in locals():
		RTfeatures=RTfeature.copy()
		PROfeatures=PROfeature.copy()

	else:
		RTfeatures=np.vstack((RTfeatures,RTfeature))
		PROfeatures=np.vstack((PROfeatures,PROfeature))

VL = np.array([x[4] for x in data])
CD4 = np.array([x[5] for x in data])


X = np.concatenate((RTfeatures, PROfeatures, np.reshape(VL,(len(data),1)), np.reshape(CD4,(len(data),1))), axis=1)
X = StandardScaler().fit_transform(X)
y = np.array([x[1] for x in data])


#Do Machine Learning

cfr = RandomForestClassifier(n_estimators=200)
SVec = SVC(C=300)

#Simple K-Fold cross validation. 4 folds.
cv = cross_validation.KFold(len(X), 5, indices=False)

RFresults = []
SVMresults = []
for traincv, testcv in cv:
    RFfit = cfr.fit(X[traincv], y[traincv])
    RFscore = RFfit.score(X[testcv], y[testcv])
    RFpredicts = RFfit.predict(X[testcv])

    RFresults.append( RFscore )

    SVMfit = SVec.fit(X[traincv], y[traincv])
    SVMscore = SVMfit.score(X[testcv], y[testcv])
    SVMpredicts = SVMfit.predict(X[testcv])

    SVMresults.append(SVMscore)

print "RF: " + str(RFresults)
print "RF sum" + str(RFpredicts.sum())
print "SCV: " + str(SVMresults)
print "SVM sum" + str(SVMpredicts.sum())
#print "SVC" +str(SVMpredicts)




