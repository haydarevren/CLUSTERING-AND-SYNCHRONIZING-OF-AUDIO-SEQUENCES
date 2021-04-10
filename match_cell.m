function [M] = match_cell(FILENAMES,HS)

n=size(FILENAMES,2);
M=zeros(n,n,2);
for i = 1:1:n
    [x,fs]=readaudio(char(FILENAMES(1,i)));
    R=match_query(x,fs);
    m=size(R,1);
    for k = 1:1:m
        M(i,R(k,1),1)=(R(k,2)>HS);
        M(i,R(k,1),2)=R(k,3);
    end
end
