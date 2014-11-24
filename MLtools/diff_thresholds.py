#!/usr/bin/env python
from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
def thresh_score(y, probas, thresholds):
	scores = []
	for thresh in thresholds:
		newprobas = []
		for p in probas:
			if p>thresh:
				newprobas.append(1)
			else:
				newprobas.append(0)

		scores.append(accuracy_score(y, newprobas))
	return scores


def thresh_score_prec_recall(y, probas, thresholds):
	scores = []
	prec = []
	recall = []
	for thresh in thresholds:
		newprobas = []
		for p in probas:
			if p>thresh:
				newprobas.append(1)
			else:
				newprobas.append(0)

		scores.append(accuracy_score(y, newprobas))
		prec.append(precision_score(y, newprobas))
		recall.append(recall_score(y, newprobas))
	return [scores, prec, recall]


#print thresh_scorePR([0,1,0,1],[.2,.6,.4,.8], [.3,.5,.7])