function P2 = PR( PEPTIDE, Ma)
%PEPTIDE is a given sequence of amino acids
%Ma is a given phyco-chemical property

alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

clear P2
for i1=1:length(PEPTIDE)
    for i2=1:length(PEPTIDE)
        P2(i1,i2)=Ma(find(alfabeto==PEPTIDE(i1)))+Ma(find(alfabeto==PEPTIDE(i2)));
    end
end
P2=(P2-min(min(abs(P2))))./(max(max(abs(P2)))-min(min(abs(P2))));
if size(P2,1)>250
    P2=imresize(P2,[250 250]);
end


end

