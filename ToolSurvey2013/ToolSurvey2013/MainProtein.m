
%As classifier we have used LibSVM:  http://www.csie.ntu.edu.tw/~cjlin/libsvm/
%notice that before classification the features are normalized between 0 and
%1

%Let us define PROT a given protein and PP a given physico-chemical
%property

%%%%%%%%%%%%%%   AMINO ACID PROTEIN DESCRIPTORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

%amino acid sequence (AAS) 
clear C
for j=1:20
    C(j)=sum(PROT==alfabeto(j))/length(PROT);%alfabeto contains the ID of the amino-acids
end


% 2-gram 
clear C
alfa20{1}='A';alfa20{2}='C';alfa20{3}='D';alfa20{4}='E';alfa20{5}='F';alfa20{6}='G';alfa20{7}='H';alfa20{8}='I';alfa20{9}='K';alfa20{10}='L';alfa20{11}='M';alfa20{12}='N';alfa20{13}='P';alfa20{14}='Q';alfa20{15}='R';alfa20{16}='S';alfa20{17}='T';alfa20{18}='V';alfa20{19}='W';alfa20{20}='Y';
C=Ngram(PROT,2,alfa20);


% Quasi Residue Couple  
C=single(QRcouple2(PROT,3,PP));


%Autocovariance approach descriptor:
C=EstraggoFeaturesAC(PROT,PP);

%Amino Acid Group Based Physicochemical Encoding     
C=AminoAcidGroupBasedPhysicochemical(PROT,MM,1,2);

%AAIndexLoc (AA)  
C=AAindexLoc(PROT,PP,alfa);%alfa is the used amino-acid alphabet

%Global Encoding   
C=GlobalEncoding(PROT);

%Full Sequence  
C=FullSequencePhysicoChemical(PROT,PP);

%N-Gram   
clear C
alfa20{1}='A';alfa20{2}='C';alfa20{3}='D';alfa20{4}='E';alfa20{5}='F';alfa20{6}='G';alfa20{7}='H';alfa20{8}='I';alfa20{9}='K';alfa20{10}='L';alfa20{11}='M';alfa20{12}='N';alfa20{13}='P';alfa20{14}='Q';alfa20{15}='R';alfa20{16}='S';alfa20{17}='T';alfa20{18}='V';alfa20{19}='W';alfa20{20}='Y';
alfa4{1}='LVIMC';alfa4{2}='ASGTP';alfa4{3}='FYW';alfa4{4}='EDNQKRH';
alfa5{1}='LVIMC';alfa5{2}='ASGTP';alfa5{3}='FYW';alfa5{4}='EDNQ';alfa5{5}='KRH';
alfa8{1}='LVIMC';alfa8{2}='AG';alfa8{3}='ST';alfa8{4}='P';alfa8{5}='FYW';alfa8{6}='EDNQ';alfa8{7}='KR';alfa8{8}='H';
alfa15{1}='LVIM';alfa15{2}='C';alfa15{3}='A';alfa15{4}='G';alfa15{5}='S';alfa15{6}='T';alfa15{7}='P';alfa15{8}='FY';alfa15{9}='W';alfa15{10}='E';alfa15{11}='D';alfa15{12}='N';alfa15{13}='Q';alfa15{14}='KR';alfa15{15}='H';

C=[single(Ngram(PROT,2,alfa20))];
C=[C; single(Ngram(PROT,2,alfa15))];
C=[C; single(Ngram(PROT,3,alfa8))];
C=[C; single(Ngram(PROT,3,alfa5))];
C=[C; single(Ngram(PROT,3,alfa4))];


% Split amino acid composition
[C]=AminoAcidComposition(PROT);


%discrete  wavelet
I=CreoSeqDaProt(PROT,PP);%substitute each amino acid with its value in the given property
CA=I;
F=[];
for i=1:4
    [CA,CD] = dwt(CA,'bior3.3');%matlab function
    CC=dct(CA);%matlab function
    F=[F CC(1:5) min(CA) max(CA) mean(CA) std(CA) min(CD) max(CD) mean(CD) std(CD)];%it stores the descriptor
end
C=F;

%Normalized Feature Vectors
alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];
tmp=1;
for i=1:20
    for j=1:20
        Tabella(tmp,1)=alfabeto(i) ;
        Tabella(tmp,2)=alfabeto(j) ;
        tmp=tmp+1;
    end
end
tmp=1;
for i=1:20
    for j=1:20
        TabellaVal(tmp,1)=PP(i);
        TabellaVal(tmp,2)=PP(j);
        tmp=tmp+1;
    end
end
NormalizedFV(PROT,PP,Tabella,TabellaVal);

%Physicochemical 2-Grams    
C=single(Physicochemical2Grams(PROT,PP,Tabella,TabellaVal{mm}));

% entropy  
clear C
alfa20{1}='A';alfa20{2}='C';alfa20{3}='D';alfa20{4}='E';alfa20{5}='F';alfa20{6}='G';alfa20{7}='H';alfa20{8}='I';alfa20{9}='K';alfa20{10}='L';alfa20{11}='M';alfa20{12}='N';alfa20{13}='P';alfa20{14}='Q';alfa20{15}='R';alfa20{16}='S';alfa20{17}='T';alfa20{18}='V';alfa20{19}='W';alfa20{20}='Y';
alfa4{1}='LVIMC';alfa4{2}='ASGTP';alfa4{3}='FYW';alfa4{4}='EDNQKRH';
alfa5{1}='LVIMC';alfa5{2}='ASGTP';alfa5{3}='FYW';alfa5{4}='EDNQ';alfa5{5}='KRH';
alfa8{1}='LVIMC';alfa8{2}='AG';alfa8{3}='ST';alfa8{4}='P';alfa8{5}='FYW';alfa8{6}='EDNQ';alfa8{7}='KR';alfa8{8}='H';
alfa15{1}='LVIM';alfa15{2}='C';alfa15{3}='A';alfa15{4}='G';alfa15{5}='S';alfa15{6}='T';alfa15{7}='P';alfa15{8}='FY';alfa15{9}='W';alfa15{10}='E';alfa15{11}='D';alfa15{12}='N';alfa15{13}='Q';alfa15{14}='KR';alfa15{15}='H';

C=[single(Ngram(PROT,2,alfa20))];%to extract 2-gram using the given alphabet
C=[C; single(Ngram(PROT,2,alfa15))];
C=[C; single(Ngram(PROT,3,alfa8))];%to extract 3-gram using the given alphabet
C=[C; single(Ngram(PROT,3,alfa5))];
C=[C; single(Ngram(PROT,3,alfa4))];
C=CalcoloEntropia(C,25);%Entropy descriptor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MATRIX REPRESENTATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PSSM
EstrarrePSSM(PROT,[]);

%SMR
SMR(PROT,Ma);%Ma is a substitution matrix

%PR
PR(PROT,PP);

%Wavelet
I=CreoSeqDaProt(PROT,PP);
cwt(I,1:100,'meyr');

%Backbone
gflstruct = getpdb(nome);%nome is the id of the protein in the PDB database
pdbwrite('e:\Nanni\Documenti\MATLAB1\DATA\test.pdb', gflstruct);
Backbone=CalculateAtomDist('e:\Nanni\Documenti\MATLAB1\DATA\test.pdb',0,0);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MATRIX REPRESENTATION DESCRIPTOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Let us define RappMatriciale a given matrix representation 

%Average Blocks
C=AvBlock(RappMatriciale);

%Single Average
C=SingleAvg(RappMatriciale,PROT,alfabeto);

%Pseudo PSSM
C=PseudoPSSM(RappMatriciale , 15);

%Autocovariance matrix
C=AutoCov(RappMatriciale,15);

%A variant of 2 gram  (2GV) 
alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];
tmp=1;
for i=1:20
    for j=1:20
        Tabella(tmp,1)=alfabeto(i) ;
        Tabella(tmp,2)=alfabeto(j) ;
        tmp=tmp+1;
    end
end
tmp=1;
for i=1:length(alfabeto)
    for j=1:length(alfabeto)
        for ij=1:length(alfabeto)
            Tabella3(tmp,1)=alfabeto(i) ;
            Tabella3(tmp,2)=alfabeto(j) ;
            Tabella3(tmp,3)=alfabeto(ij) ;
            tmp=tmp+1;
        end
    end
end
C = NgramMatrice(RappMatriciale , PROT, 2, Tabella);%using 2-gram
C = NgramMatrice(RappMatriciale , PROT, 3, Tabella3);%using 3-gram

%Texture descriptors
mapping1HF=getmaplbphf(8);%mapping used for extracting LBP-HF features
mapping2HF=getmaplbphf(16);
NUM=1;%NUM is the number of sub-windows extracted from the matrix
[AC2 AC3] = Tessiturali( RappMatriciale, NUM, mapping1HF,mapping2HF );

%SVD
[U,S,V] = svd(RappMatriciale);%matlab function
C=diag(S);

%DCT
S=dct2(RappMatriciale);%matlab function
S=S(1:20,1:20);
C=S(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%














