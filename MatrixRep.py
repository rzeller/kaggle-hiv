#!/usr/bin/env python

#Below are different functions used to represent proteins as matrices.  

from Bio.SubsMat import MatrixInfo
import os
import numpy as np
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC

def SMR(protein, subMat = None):
    #protein is the AA sequence of the protein you would like to represent as a matrix
    #subMat is the substitution matrix (i.e. Blosum, PAM etc.) used for the substitution scores
    #default is blosum62


    #adding in substitution matrix if not provided
    if subMat == None:
        subMat = MatrixInfo.blosum62


    aminoacids = ('A', 'R', 'N', 'D', 'C', 'Q', 'E', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V')
    Mat = np.zeros((len(protein),20)) 
    for AAa in range(len(aminoacids)):
        for AAb in range(len(protein)):
            pair = (protein[AAb], aminoacids[AAa])
            reversepair = (aminoacids[AAa],protein[AAb])

            if pair not in subMat and reversepair not in subMat:
                Mat[AAb,AAa] = 0
            elif pair not in subMat:
                Mat[AAb,AAa] = subMat[reversepair]
            else:
                Mat[AAb,AAa] = subMat[pair]

    return {"column labels" : aminoacids, "SMR":Mat}





def PSSM(protein, database = "uniprot_sprot.fasta", numIter = 3, outfile = "PSSMout.txt"):
    #Requires (unzipped) database of protein sequences, swissprot is default
    #Requires that blast+ command line tools are installed (no internet based interface with python is supported by BLAST at this time)
    #download blast+ here: http://www.ncbi.nlm.nih.gov/books/NBK1763/ and install in usr/bin/applications
    
    #The compressed SwissProt protein sequence file is in the github repo- unzipped files and databases are too large to sync
    #can pull and unzip locally
    

    #To make a Blast database from an (unzipped) sequence file run MakeDB.py on the file
    #MakeDB.py will create a Blast database of the same name in the same folder (ignore the .phr and .psq extensions)
    #The resulting Blast database can then be used for creating PSSM


    ###Inputs###
    #protein: AA sequence as string, list, or file

    #database: the path of the database of protein sequences to compare against
    #'uniprot_sprot.fasta' is default

    #numIter: number of iterations when comparing to database
    # 3 is default (min for PSSM matrix)

    #outfile: filename of the output PSSM matrix
    #"PSSMout.txt" is default


    #####RETURNS#####
    #"Labeled PSSM" a python list containing labels of the PSSM in the first item
    #subsequent items correspond to each amino acid in the sequence and the PSSM values

    #"PSSM values" is an nx20 matrix with just the PSSM values, no labels


    #Converting protein to file that blast+ can work with (if not a file already)
    if type(protein) is not "file":
        with open("ProteinQuery.fasta", "w") as output_handle:
            sequences = []
            record = SeqRecord(Seq(protein, IUPAC.protein), id="query_protein") 
            SeqIO.write(record, output_handle, "fasta")
            query = "ProteinQuery.fasta"
    else:
        query = protein

    print "running"


    #Constructing strings to run on command line
    BlastString = "psiblast -db " + database + " -query " + query \
                 + " -out_ascii_pssm " + outfile + " -num_iterations " + str(numIter)

    os.system(BlastString)
    print BlastString

    #Parsing file output from blast+ to create working PSSM matrix
    with open(outfile, 'r') as PSSMtxt:
        PSSMlist = []
        for line in PSSMtxt:
            PSSMlist.append(line.split())



    #labeledPSSM is a python list with the first item labels for each column (amino acids)
    #each subsequent item corresponds to an amino acid in the query protein
    #subsequent items contain the amino acid number, the letter, then 20 values of PSSM matrix
    labeledPSSM = []
    labels = ['-','-']
    labels.extend(PSSMlist[2][0:20])
    labeledPSSM.append(labels)

    rows = [x[0:22] for x in PSSMlist[3:len(protein)+3]]
    for i in rows:
        labeledPSSM.append(i)


    #PSSM values is just a nx20 matrix containing the values of the PSSM
    PSSMvalues = [x[2:22] for x in labeledPSSM[1:]]
    PSSMvalues = np.array(PSSMvalues)
    print PSSMvalues


    return {"Column labels": np.array(labels), "PSSM Values": PSSMvalues}




PSSM("ACGTGDF", database = "/Users/Ryan/PythonProjects/Databases/uniprot_sprot.fasta")
