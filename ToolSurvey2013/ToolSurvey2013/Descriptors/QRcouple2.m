function X=QRcouple(seq,m,P)

%seq=protein
%m=order
%P=physicochemical property 

alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

N=size(seq,2);
t=1;
for ii=1:m
    for i=1:20
        for j=1:20
            X(t)=0;
            for n=1:N-ii
                if seq(n)==alfabeto(i) & seq(n+ii)==alfabeto(j)
                    X(t)=X(t)+P(i)+P(j);
                end
            end
            if X(t)>0
                X(t)=X(t).*(1/(N-ii));
            end
            t=t+1;
        end
    end     
end