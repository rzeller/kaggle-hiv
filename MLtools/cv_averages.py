#!/usr/bin/env python
from __future__ import division
from sklearn.metrics import *
import numpy as np


def cv_metrics(evaluator, cv, X, y, precision_recall = False, auc = False, log_loss = False, pos_label = 1, reduce_data = False):
	#Takes an sklearn ML evaluator object and a sklearn cv object and returns average scores of various metrics across folds
	#can only reduce data for ensemble methods (like random forest)
	#pos_label is the label for positive samples (1 is default)
	#set precision_recall, auc, and log_loss to True if you want those scores evaluated for each fold

	results = []
	precision = []
	recall = []
	F1 = []
	truepos = []
	falsepos = []
	auc = []

	if reduce_data is not False:
		evaluatorFit = evaluator.fit(X, y)
		if "n_estimators" in evaluatorFit.get_params():
			X = evaluatorFit.transform(X)


	for traincv, testcv in cv:
	        

		evaluatorFit = evaluator.fit(X[traincv], y[traincv])

		FoldScore = evaluatorFit.score(X[testcv], y[testcv])
		results.append(FoldScore)

		FoldPredicts = evaluatorFit.predict(X[testcv])


		if precision_recall is not False:
			precision.append(precision_score(y[testcv], FoldPredicts))
			recall.append(recall_score(y[testcv], FoldPredicts)) 
			F1.append(f1_score(y[testcv], FoldPredicts)) 
			# conf_mat = confusion_matrix(y[testcv],FoldPredicts)
			# truepos.append(conf_mat[1][1]/(conf_mat[1][1]+conf_mat[1][0]))
			# falsepos.append(conf_mat[0][1]/(conf_mat[0][1]+conf_mat[1][1]))

			
		if auc is not False:
		    
			FoldProbas = evaluatorFit.predict_proba(X[testcv])
			Oneprobas = [x[1] for x in FoldProbas]
			auc.append(roc_auc_score(y[testcv], Oneprobas))


	return {"score": np.array(results).mean(), \
			"precision": np.array(precision).mean(), \
			"recall": np.array(recall).mean(), \
			"F1": np.array(F1).mean(),\
			# "truepos": np.array(truepos).mean(), \
			# "falsepos": np.array(falsepos).mean(), \
			"auc": np.array(auc).mean() }



	        