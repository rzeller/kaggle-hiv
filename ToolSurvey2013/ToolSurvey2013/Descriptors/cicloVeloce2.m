function Feat=cicloVeloce2(Tr,Tabella,Feat)

for j=1:size(Tr,2)-1
    indice=find(Tabella(:,1)==Tr(j) & Tabella(:,2)==Tr(j+1));
    Feat(indice)=Feat(indice)+1;
end

