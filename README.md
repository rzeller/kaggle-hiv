kaggle-hiv
==========
—————————MakeRep—————————————— 
Contains two functions SMR and PSSM 

SMR:
SMR will make a matrix representation of a protein based on a given substitution matrix (i.e. blosum or pam)
common substituion matrices can be found in the biopython package (Bio.SubsMat.MatrixInfo)


PSSM: 
PSSM creates a PSSM representation of a protein by searching against a database of protein sequences and creating a matrix based on the degree of conservation of each amino acid in similar proteins contained in the database.

Requires (unzipped) file of protein sequences such as swissprot (http://www.uniprot.org/downloads), 
Requires that blast+ command line tools are installed (no internet based interface with python is supported by BLAST at this time)
download blast+ here: http://www.ncbi.nlm.nih.gov/books/NBK1763/ and install in usr/bin/applications


The compressed SwissProt protein sequence file is in the github repo: rbloom5/Sequence-Databases, unzipped files and databases are too large to sync
The best method is probably to pull zipped file and then unzip locally into a different directory outside the github repo


To make a Blast database from an (unzipped) sequence file run MakeDB.py on the file.  
This will create a Blast database of the same name in the same folder (ignore the .phr and .psq extensions)
The resulting Blast database can then be used for creating PSSM


COMMON ERROR: if blast runs, but outfile is not found, it may be that there were no hits in the database.  
This is often because query sequence is too short
this query sequence has worked in the past and can work for testing/debugging code: 
"ACGASQWERASDQWERTYPLKMNASDQWERPOLKFDREQEPOLKCWEDFFMNMOPFDTREWQTYDSTEDF"
--------------------------------------------------------------------------------------------------------------------------------
