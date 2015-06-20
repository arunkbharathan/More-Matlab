function speakerID(a)
% A speaker recognition program. a is a string of the filename to be tested
% against the database of sampled voices and it will be evaluated whose
% voice it is.
% - Example -
% to test a 'test.wav' file then,
% >> speakerID('test.wav')
%
% - Reference -
% Lasse Molgaard and Kasper Jorgensen, Speaker Recognition,
% www2.imm.dtu.dk/pubdb/views/edoc_download.php/4414/pdf/imm4414.pdf
%
% Mike Brooks, VOICEBOX, Free toolbox for MATLab,
% www.ncl.ac.uk/CPACTsoftware/MatlabLinks.html
% disteusq.m enframe.m kmeans.m melbankm.m melcepst.m rdct.m rfft.m from
% VOICEBOX are used in this program.
test.data = wavread(a); % read the test file
name = ['arun';'amit';'nrja']; % name of people in the database
fs = 16000; % sampling frequency
C = 8; % number of centroids
% Load data
disp('Loading data...')
[train.data] = Load_data(name);
% Calculate mel-frequecny cepstral coefficients for training set
disp('Calculating mel-frequency cepstral coefficients for training set...')
[train.cc] = mfcc(train.data,name,fs);
% Perform K-means algorithm for clustering (Vector Quantization)
disp('Performing K-means...')
[train.kmeans] = kmean(train.cc,C);
% Calculate mel-frequecny cepstral coefficients for training set
disp('Calculating mel-frequency cepstral coefficients for test set...')
test.cc = melcepst(test.data,fs,'x');
% Compute average distances between test.cc with all the codebooks in
% database, and find the lowest distortion
disp('Compute a distortion measure for each codebook...')
[result index] = distmeasure(train.kmeans,test.cc);
% Display results - average distances between the features of unknown voice
% (test.cc) with all the codebooks in database and identify the person with
% the lowest distance
disp('Display the result...')
dispresult(name,result,index)