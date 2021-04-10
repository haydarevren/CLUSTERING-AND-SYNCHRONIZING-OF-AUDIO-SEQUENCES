function  plot_clusters(C,FILENAMES)
p=size(C,1);
m=size(C,2);

for i=1:m;
    figure,
    n=size(find(C(:,i,1)>0),1);
    ft=0;
    for k=1:n;
         [x,fs]=readaudio(char(FILENAMES(C(k,i,1))));
         ft=max(ft,C(k,i,2)*0.032+(length(x)-1)/fs);
    end
    
    for l=1:n;
         [x,fs]=readaudio(char(FILENAMES(C(l,i,1))));
%          s(m*(l-1)+i)=subplot(p,1,l);
         subplot(n,1,l),plot((C(l,i,2)*0.032:1/fs:(C(l,i,2)*0.032+(length(x)-1)/fs)),x)
         axis([0 ft -1 1])
         title(FILENAMES(C(l,i,1)),'Interpreter','none')
         hold on;
    end
end
