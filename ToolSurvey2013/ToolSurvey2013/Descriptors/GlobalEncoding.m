function  FEAT=GlobalEncoding(P) 
%Protein functional class prediction using global encoding of amino acid
%sequence

%amino acids are first classified into the following six classes:
C1='AVLIMC';
C2='FWYH';
C3='STNQ';
C4='KR';
C5='DE';
C6='GP';

L=16;%size of the patch used for extracting the descriptors

if length(P)<16
    P(length(P):16)=P(length(P));%to avoid proteins too short
end

%For each combination, each of which contains three different classes
%(hence we have ten combinations):
Len=length(P);
for i=1:Len
    t=1;
    if sum(P(i)==C1)|sum(P(i)==C2)|sum(P(i)==C3)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C2)|sum(P(i)==C4)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C2)|sum(P(i)==C5)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C2)|sum(P(i)==C6)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C3)|sum(P(i)==C4)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C3)|sum(P(i)==C5)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C3)|sum(P(i)==C6)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C4)|sum(P(i)==C5)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C4)|sum(P(i)==C6)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
    t=t+1;
    if sum(P(i)==C1)|sum(P(i)==C5)|sum(P(i)==C6)
        H(t,i)=1;
    else
        H(t,i)=0;
    end
end

%“composition," i.e., the frequency of 0s and 1s
for i=1:10%the 10 binary sequence H
    S=max([length(P)/L 1]);
    t=1;
    for j=1:L
        F(i,t)=sum(H(i, floor((j-1)*S+1:j*S) )==1)/(S);
        t=t+1;
        F(i,t)=sum(H(i, floor((j-1)*S+1:j*S) )==0)/(S);
        t=t+1;
    end
end

%“transition”, i.e., the percent of frequency with which 1 is followed by 0 or 0 is followed by 1  in a characteristic sequence
for i=1:10
    S=max([length(P)/L 1]);
    t=1;
    for j=1:L
        Sezione=H(i, floor((j-1)*S+1:j*S) );
        Sezione1=Sezione(2:length(Sezione));
        Sezione(length(Sezione))=[];
        F1(i,t)=sum(Sezione==1 & Sezione1==0)+sum(Sezione==0 & Sezione1==1);
        t=t+1;
    end
end

FEAT=[reshape(F,size(F,1)*size(F,2),1); reshape(F1,size(F1,1)*size(F1,2),1)];