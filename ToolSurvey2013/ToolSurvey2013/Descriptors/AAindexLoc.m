function [ FEAT ] = AAindexLoc( SEQ , MM ,alfa )

T=[single(Ngram(SEQ,2,alfa ))];

%amino acid composition
for j=1:20
    C(j)=sum(SEQ==alfa(j))/length(SEQ);
end

%weighted AA composition
for j=1:20
    W(j)=C(j)*MM(j);
end

FEAT=[T' C W];


