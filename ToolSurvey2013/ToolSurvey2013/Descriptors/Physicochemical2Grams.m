function Feat=Physicochemical2Grams(Training,MM,Tabella,TabellaVal)
%Training  is the amino-acid sequence
%MM a given physico-chemical protein


Feat(1:800)=0;
for j=1:length(Training)-1
    indice=find(Tabella(:,1)==Training(j) & Tabella(:,2)==Training(j+1));
    if min(size(indice))>0
        VAL1=TabellaVal(indice,1);
        VAL2=TabellaVal(indice,2);
        Feat(indice)=Feat(indice)+VAL1;
        Feat(indice+400)=Feat(indice+400)+VAL2;
    end
end
Feat=Feat/(length(Training)-1);
