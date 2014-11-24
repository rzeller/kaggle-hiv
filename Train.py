import csv
from Bio.Seq import Seq
import MatrixRep
from MatFeatExtract import *
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn import cross_validation
from random import shuffle
from sklearn.preprocessing import StandardScaler
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import f_classif
import matplotlib.pyplot as plt

import sys
sys.path.append('MLtools/')
import cv_averages



def FeatureExtract(data, database=""):
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
	response = np.array([x[1] for x in data])

	#ML data is a numpy array with the response (0 or 1) in the first column, then all the features in subsequent columns
	MLdata = np.concatenate((np.reshape(response,(len(data),1)),RTfeatures, PROfeatures, \
			np.reshape(VL,(len(data),1)), np.reshape(CD4,(len(data),1))), axis=1)

	return MLdata



def select_shuffle(MLdata, firstIndex=0, lastIndex=None):
	#Allows you to reduce the training data and slice it into number of 0's and 1's
	#the final 206 entries in data (once sorted in main) will all be 1's, so if the firstIndex is 600 and lastIndex is
	#1000 (or unspecified) then you will have about half pos, half neg for the training set
	#default is just to take all the data though 

	if lastIndex == None:
		lastIndex = np.shape(MLdata)[0]

	MLdataNew = MLdata[firstIndex:lastIndex,:]

	indeces =  range(np.shape(MLdataNew)[0])
	shuffle(indeces)

	MLdataShuff = MLdataNew[indeces,:]
	MLdataShuff = MLdataShuff[:,:]

	y = MLdataShuff[:,0]
	X = MLdataShuff[:,1:np.shape(MLdataShuff)[1]]

	return {'y': y, 'X': X}



#######  MAIN   ###########

database='databases/uniprot_sprot.fasta'

#Load in data
data=[]
with open('training_data.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile, delimiter=',')
	reader.next()
	for row in reader:
		data.append((int(row[0]),int(row[1]),row[2],row[3],float(row[4]),int(row[5])))

#sort the training data so that all the 0's are first, and all the 1's are after that
data.sort(key=lambda x: x[1])

#Extract features of proteins and add in cd4 and viral load
MLdata = FeatureExtract(data, database)


#Create X and y vectors for machine learning (and shuffle so cv's work better)
XandY = select_shuffle(MLdata,firstIndex = 400)
X = XandY['X']
y = XandY['y']



#Do Machine Learning 
Svec = SVC(C=2, probability=True, class_weight = 'auto')
cv = cross_validation.KFold(len(X), 5, indices=False)
Xreduce = SelectKBest(f_classif, 25).fit_transform(X,y) #reduces the data for the SVM classifier - should be optimized


#cv_averages is a package I made - it is in the folder MLtools
Metrics = cv_averages.cv_metrics(Svec, cv, Xreduce, y, precision_recall = True, auc = True)
print Metrics
#{'recall': 0.60263754963131022, 'auc': 0.80881485490512639, 'score': 0.73454545454545461, 'precision': 0.6610307087441234, 'F1': 0.62633444653818171}






