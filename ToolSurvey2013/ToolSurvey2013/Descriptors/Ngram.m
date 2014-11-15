function Feat=Ngram(Training,N,alfabeto)
%Training is the amino-acid sequence
%N is the value of the N-gram
%alfabeto is the alphabet used for building the N-gram histogram

if N==2
    tmp=1;
    for i=1:length(alfabeto)
        for j=1:length(alfabeto)
            Tabella(tmp,1)=(i) ;
            Tabella(tmp,2)=(j) ;
            tmp=tmp+1;
        end
    end
    Tabella=single(Tabella);
    
elseif N==3
    
    tmp=1;
    for i=1:length(alfabeto)
        for j=1:length(alfabeto)
            for ij=1:length(alfabeto)
                Tabella(tmp,1)=(i) ;
                Tabella(tmp,2)=(j) ;
                Tabella(tmp,3)=(ij) ;
                tmp=tmp+1;
            end
        end
    end
    Tabella=single(Tabella);
end

Feat=single(zeros(length(alfabeto)^N,1));
Tr=single(ConvertiAlfabeto(Training,alfabeto));

Feat=eval(strcat('cicloVeloce',num2str(N),'(Tr,Tabella,Feat)'));

Feat=Feat./(size(Tr,2)-N+1);
