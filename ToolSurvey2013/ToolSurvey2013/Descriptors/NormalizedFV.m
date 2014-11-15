function Feat=NormalizedFV(Training,MM,Tabella,TabellaVal)
%Training, amino-acid sequence
%MM, physico-chemical property
%Tabella, contains all the couple of amino acids  
%TabellaVal, contains all the couple of amino acids where each amino acid is substituted with its value in the given property

if size(TabellaVal,1)>1
    Feat(1:400,max([length(Training) 400]))=0;
    for j=1:length(Training)-1
        indice=find(Tabella(:,1)==Training(j) & Tabella(:,2)==Training(j+1));
        if min(size(indice))>0
            VAL1=TabellaVal(indice,1);
            VAL2=TabellaVal(indice,2);
            Feat(indice,j)=Feat(indice,j)+VAL1+VAL2;
        end
    end
    Feat=Feat./(length(Training)-1);
    
    [U,S,V] = svd(Feat);
    Feat=diag(S);
    
else
    
    Feat(1:400,max([length(Training) 400]))=0;
    for j=1:length(Training)-1
        indice=find(Tabella(:,1)==Training(j) & Tabella(:,2)==Training(j+1));
        if min(size(indice))>0
            Feat(indice,j)=1;
        end
    end
    Feat=Feat./(length(Training)-1);
    
    [U,S,V] = svd(Feat);
    Feat=diag(S);

end
