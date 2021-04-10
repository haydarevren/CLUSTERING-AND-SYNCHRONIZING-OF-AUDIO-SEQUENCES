function SP2 = shortestpath_correction (SP1,M)
SP2=SP1;
n=size(SP2,1);
for i=1:n;
    for k=1:n;
        if (M(k,i,1)==1 && M(k,i,2)==0 )
         SP2(k,i)=0;
        end
    end
end