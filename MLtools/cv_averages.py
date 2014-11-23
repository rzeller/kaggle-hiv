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
			# "truepos": np.array(truepos).mean(), \
			# "falsepos": np.array(falsepos).mean(), \
			"auc": np.array(auc).mean() }



	        #fpr, tpr, thresh = roc_curve(y[testcv],Oneprobas, pos_label=1)
	        #plt.figure()
	        #plt.plot(fpr, tpr)
	        #thresh_scores, preci, recall = diff_thresholds.thresh_score_prec_recall(y[testcv],Oneprobas,thresholds)
	        #prec, rec, thresh = precision_recall_curve(y[testcv],Oneprobas, pos_label=1)
	#             plt.figure()
	#             plt.plot(thresh, prec[:len(prec)-1], 'r', thresh, rec[:len(rec)-1], 'b')
	        

	        # if sample_thresh == []:
	        #     sample_thresh = np.array(thresh_scores)
	        #     sample_prec = np.array(preci)
	        #     sample_rec = np.array(recall)
	        # else:
            #     sample_thresh = np.vstack((sample_thresh,np.array(thresh_scores)))
            #     sample_prec = np.vstack((sample_prec,np.array(preci)))
            #     sample_rec = np.vstack((sample_rec,np.array(recall)))

            
            
            
            
        #     #RFpr = precision_recall_fscore_support(y[testcv],RFpredicts)
        #     SVMpr = precision_recall_fscore_support(y[testcv],SVMpredicts)
        #     #RFp.append(RFpr[0][1])
        #     #RFr.append(RFpr[1][1])
        #     SVMp.append(SVMpr[0][1])
        #     SVMr.append(SVMpr[1][1])


        # #FinalRF.append(np.array(RFresults).mean())
        # FinalSVM.append(np.array(SVMresults).mean())
        # #FinalRFp.append(np.array(RFp).mean())
        # #FinalRFr.append(np.array(RFr).mean())
        # FinalSVMp.append(np.array(SVMp).mean())
        # FinalSVMr.append(np.array(SVMr).mean())
        # aucF.append(np.array(auc).mean())
        # plt.figure()
        # plt.plot(thresholds,np.average(sample_thresh, axis=0),'r',\
        #          thresholds,np.average(sample_prec, axis=0),'g',\
        #          thresholds,np.average(sample_rec, axis=0),'y')
        
        # threshF.append(np.average(sample_thresh, axis=0))
        # precF.append(np.average(sample_prec, axis=0))
        # recF.append(np.average(sample_rec, axis=0))