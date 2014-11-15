function Feat=cicloVeloce4(Tr,Tabella,Feat)

for j=1:size(Tr,2)-2
    indice=find(Tabella(:,1)==Tr(j) & Tabella(:,2)==Tr(j+1)& Tabella(:,3)==Tr(j+2));
    Feat(indice)=Feat(indice)+1;
end

