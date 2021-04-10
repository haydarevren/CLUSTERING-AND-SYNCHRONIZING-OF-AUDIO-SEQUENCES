function audio_allign
clear_hashtable
[filename, path] = uigetfile({ '*.aif', 'Aif files (*.aif)';'*.aiff', 'Aiff files (*.aiff)';'*.mp3', 'Mp3 files (*.mp3)';'*.wav', 'Wave files (*.wav)'; '*.*', 'All Files (*.*)'},'Choose file','MultiSelect','on');
add_tracks(filename);
HS=4;
M=match_cell(filename,HS);
B = biograph(M(:,:,1)-diag(diag(M(:,:,1))),0.032*M(:,:,2), filename, 'ShowWeights', 'on','ShowArrows', 'on');
view(B)
C=find_clusters(M);
plot_clusters(C,filename);