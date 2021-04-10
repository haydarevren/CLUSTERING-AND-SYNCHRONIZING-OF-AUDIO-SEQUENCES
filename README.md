# CLUSTERING-AND-SYNCHRONIZING-OF-AUDIO-SEQUENCES

People can simultaneously record a single moment and create a large collection of unorganized and unprocessed audio and video recordings. To properly playback, edit, and analyze these collections, distinct event identification and time synchronization is required. 

The aim is to align these audio clips according to their starting points on an unknown time line. 

One major difference from the common audio alignment setup is that there is no clean original source database but only some possibly noisy observations of the source and none of the audio clips have to cover the entire timeline.

There are certain limitations. First of all, the computational cost in these methods is high in audio applications. Audio matching application works pairwise. Assuming there are K number of clips, one needs to apply pairwise matching on the order of O(K^2). 

In addition to that, if the audio clips do not overlap or some of the data is missing in one of the audio clips, it is not always clear how to apply simple correlation or template matching ideas. 

An obvious way to reduce computational complexity and the number of data is working on a feature space instead of working directly on audio data. Even when working with features, the problem can be still challenging when there are multiple shorter recordings and not a ’ground truth timeline’.

In this project, we used Avery Wang’s landmark and hash algorithm to obtain “fingerprint” of our unorganized collection of audio data. And then, we used breadth-first search algorithm to find the clusters and time synchronization of them.

Audio Fingerprint Extraction:

First we generate a spectrogram for the audio file. Storing the full song will occupy an enormous amount of space. So instead, we store only the intense sounds in the song, the time when they appear in the song and at which frequency.

So a spectrogram for a song will be transformed from the left figure into the right one:

![image](https://user-images.githubusercontent.com/79766032/114278623-b1e12f80-99fe-11eb-8734-ff3d75a7fa9f.png)

To store this in the database in a way in which is efficient to search for a match (easy to index), we choose some of the points from within the simplified spectrogram (called “anchor points”) and zones (called “target zone”).

![image](https://user-images.githubusercontent.com/79766032/114278637-c4f3ff80-99fe-11eb-9af8-be5be88b3342.png)

For each point in the target zone, we create a hash that will be the aggregation of the following: 
the frequency at which the anchor point is located (f1) 
the frequency at which the point in the target zone is located (f2)
the time difference between the time when the point in the target zone is located in the song (t2-t1) 
the time when the anchor point is located in the song (t1)

To simplify: hash = (f1+f2+(t2-t1))+t1

Search Algorithm[CLUSTERING AND SYNCHRONIZING OF AUDIO SEQUENCES.pptx](https://github.com/haydarevren/CLUSTERING-AND-SYNCHRONIZING-OF-AUDIO-SEQUENCES/files/6290371/CLUSTERING.AND.SYNCHRONIZING.OF.AUDIO.SEQUENCES.pptx)



