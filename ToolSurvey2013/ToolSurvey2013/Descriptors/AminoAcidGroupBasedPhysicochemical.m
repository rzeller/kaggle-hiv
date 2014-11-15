%Hu and Zhang, Improving Protein Localization Prediction Using Amino Acid Group based
%physichemical encoding, BICoB 2009


function [I2]=AminoAcidGroupBasedPhysicochemical(PROT,MM,lambda,Lmin)
%PROT amino-acid sequence
%MM matrix that contains for each row a different physico-chemical property
%lambda parameter of the method
%Lmin i.e. minimum length L 

I2=[];
I3(1:10)=0;
for i=1:size(MM,1)
    %for each property
    I=PROT;
    Prot=I;
    %substitute each amino acid with its value in the given property
    I=CreoSeqDaProt(I,MM(i,:));
    %binarize
    m=mean(I);
    s=std(I);
    TH1=m+lambda*s;
    TH2=m-lambda*s;
    
    B=I.*0;%binary vector
    B(find(I>=TH1))=1;
    B(find(I<=TH2))=-1;
    
    %clustering procedure consists in merging adjacent amino acids with equal positive or negative labels into an amino acid group 
    fine=1;
    j=1;
    tt=1;%for each amino acid group
    dim=0;
    base=1;
    CL=B(j);%class of the gruppo
    clear AC Classe
    AC=[];
    while fine
        if B(j+1)==CL & CL~=0
            j=j+1;
            dim=dim+1;
            AC(tt,:)=[base dim];
            Classe(tt)=CL;%class of the amino-acid group
        elseif B(j+1)==0 & B(j+2)==CL & CL~=0
            j=j+1;
        else
            dim=0;
            j=j+1;
            CL=B(j);
            base=j;
            tt=tt+1;
        end
        if length(B)<j+2
            fine=0;
        end
    end
    
    if isempty(AC)
        I2=[I2 I3];
    else
        
        AC(find(Classe==0),:)=[];
        Classe(find(Classe==0))=[];
        
        %cut group which length is < LMIN
        TOLGO=find(AC(:,2)<Lmin);
        AC(TOLGO,:)=[];
        Classe(TOLGO)=[];
        IND=find(Classe==1);
        IND1=find(Classe==-1);
        I=[AC(IND,1); AC(IND,2); AC(IND1,1); AC(IND1,2) ]./length(Prot);
        
        IND=find(Classe==1);
        if isempty(IND)==0
            I2=[I2 AC(IND(1),:)./length(Prot)];
        else
            I2=[I2 0 0];
        end
        
        IND2=find(Classe==-1);
        if isempty(IND2)==0
            I2=[I2 AC(IND2(1),:)./length(Prot)];
        else
            I2=[I2 0 0];
        end
        
        %final descriptor
        I2=[I2 sum(Classe==1)./length(Prot) sum(Classe==-1)./length(Prot)];
        
        I2=[I2 mean(AC(:,1))./length(Prot) mean(AC(:,2))./length(Prot)];
        
        I2=[I2 mean(AC(IND,2))./length(Prot) mean(AC(IND2,2))./length(Prot)];
    end
end
I2(find(isnan(I2)))=0;

