function AAC=CalcoloEntropia(SEQ,blocco)
%SEQ is the input histogram
%blocco is the size of each patch

AAC=[];
for ij=1:blocco:length(SEQ)
    
    sub=SEQ(ij:min([length(SEQ) ij+blocco ]));
    
    %calculate entropy
    AAC= [AAC;-1*sum(log(sub+0.000001).*sub)];
end