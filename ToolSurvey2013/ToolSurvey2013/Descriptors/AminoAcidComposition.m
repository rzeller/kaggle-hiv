function AAC=AminoAcidComposition(newsequence)
%newsequence  is the amino-acid sequence

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