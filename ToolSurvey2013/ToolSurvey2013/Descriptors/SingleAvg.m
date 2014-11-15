function [ AC ] = SingleAvg( P, PR, alfabeto)
%P, matrix representation 
%PR, amino acid sequence
%alfabeto, used amin-acid alphabet

AC=[];

for i=1:length(alfabeto)
    I=find(alfabeto(i)==PR);
    if max(I)>size(P,1)
        AC(i,1:20)=0;
        break
    end
    POS=P(I,:);
    if min(size(POS))==1
        AC(i,:)=(POS);
    elseif min(size(POS))==0
        AC(i,1:20)=0;
    else
        AC(i,:)=sum(POS);
    end
end
AC(find(isnan(AC)))=0;
AC(find(isinf(AC)))=0;
AC=single(AC(:))./length(PR);%normalization
    

