function [ Feat ] = NgramMatrice( PROT , SEQ, N,  Tabella)

Tr=PROT;
alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

if N==2
    
    Feat=single(zeros(400,1));
    Feat2=Feat;
    
    for j=1:length(PROT)-1
        indice=find(Tabella(:,1)==SEQ(j) & Tabella(:,2)==SEQ(j+1));
        Feat(indice)=Feat(indice)+PROT(j,find(Tabella(indice,1)==alfabeto));
        Feat2(indice)=Feat2(indice)+PROT(j,find(Tabella(indice,2)==alfabeto));
    end
    Feat=[Feat; Feat2];
    
elseif N==3
    
    Feat=single(zeros(8000,1));
    for j=1:length(PROT)-2
        indice=find(Tabella(:,1)==SEQ(j) & Tabella(:,2)==SEQ(j+1)& Tabella(:,3)==SEQ(j+2));
        Feat(indice)=Feat(indice)+PROT(j,find(Tabella(indice,1)==alfabeto))+PROT(j,find(Tabella(indice,2)==alfabeto))+PROT(j,find(Tabella(indice,3)==alfabeto));
    end
    
end

Feat=Feat./j;
