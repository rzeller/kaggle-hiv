function I=CreoSeqDaProt(P,M);
alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

for i=1:20
    I(find(P==alfabeto(i)))=M(i);
end