function  [C]=find_clusters(M)
dg = sparse(M(:,:,1)-diag(diag(M(:,:,1))));
[s, c] = graphconncomp(dg, 'Directed', 'false', 'Weak','true' );

dg2 = sparse(M(:,:,1).*M(:,:,2));
sp=graphallshortestpaths(dg2);
sp=shortestpath_correction(sp,M);

for i=1:s;
    a(i,1) =sum(c==i);
end
p=max(a);
m=0;
for i = 1:s;
    m=m+ (a(i,1)>1);
end
C=zeros(p,m,2);

m1=1;
for i=1:s
    if (sum(c==i)>1);
        f=find(c==i);
        [sr,index]=sortrows(sp,f(1));
        sr=sr(:,f(1));
        sr=sr - min(sr)*ones(size(sp,1),1);
        C([1:size(f,2)],m1,1)=index([1:size(f,2)]);
        C([1:size(f,2)],m1,2)=sr([1:size(f,2)]);
        m1=m1+1;
    end
end
        
        