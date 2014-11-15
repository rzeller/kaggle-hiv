function Farray=EstraggoFeaturesAC(newsequence,OriginData)
% OriginData =physicochemical property 
% newsequence = protein

alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

S0=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];
AAindex = S0;
IsEnd = 0;
AAC=[];
Len = length(newsequence);
percent=zeros(1,20);
for i=1:Len
    for j=1:20
        if newsequence(i)==S0(j)
            percent(j)=percent(j)+1;
            break
        end
    end
end
percent=percent/Len;
AAC= [AAC;percent];
Pse=[];
AAnum = [];
for i=1:Len
    AAnum = [AAnum,OriginData(findstr(AAindex,newsequence(i)))];%3*n
end
Len = length(AAnum);
temp=[];
for i=1%
    t=zeros(1,20);
    for j=1:20
        for k=1:(Len-j)
            J=(AAnum(i,k)-sum(AAnum(i,:)/Len))*(AAnum(i,(k+j))-sum(AAnum(i,:)/Len));
            t(j)=t(j)+J;
        end
        t(j)=t(j)/(Len-j);
    end
    temp=[temp,t];
end
Pse=[Pse;temp];
Array=[];
Array=[AAC,Pse];
[m,n]=size(Array);
Farray=[];
Farray=cat(2,Array(1:20)/(1+0.05*sum(Array(21:40))),0.05*Array(21:40)/(1+0.05*sum(Array(21:40))));

