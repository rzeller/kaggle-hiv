function [  AC2 AC3  ] = PseudoPSSM( P, NUM, mapping1HF,mapping2HF )
%P is the matrix rapresentation
%NUM is the number of sub-windows extracted from the matrix

n=size(P,1);
I=P;

B=floor(n/NUM);
AC1=[];AC2=[];AC3=[];AC4=[];
for i=1:NUM%number of sub-windows
    RID=I( (B*(i-1))+1:min([B*i n]),: );
    
    
    %LBP-HF
    XX3=[];
    h=tesi(RID,[],8,'ci',1,2,0,mapping1HF,'h');%LBP-HF
    h=h/sum(h);
    XX3=[XX3 constructhf(h,mapping1HF)];
    h=tesi(RID,[],16,'ci',2,3,0,mapping2HF,'h');%LBP-HF
    h=h/sum(h);
    I2=[XX3 constructhf(h,mapping2HF)];
    AC2=[AC2 I2];
    
    %LPQ
    AC3=[AC3 [lpqNEW(RID,3,1,3) lpqNEW(RID,5,1,3)]];
    
    
end



