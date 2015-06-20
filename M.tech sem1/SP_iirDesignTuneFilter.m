%% Designs an IIR Filter for the mid-range of the five band equalizer.
%  Butterworth, Chebyshev Type II and Elliptic Filters are designed and
%  compared.

close all
clear all

%% Set Analog Parameters
fStop1 = 500;
fPass1 = 900;
fPass2 = 2500;
fStop2 = 3000;

Rp = 1;
Rs = 60;

%% Normalize Frequencies with respect to Nyquist Frequency
fSampling = 22050;
fNyquist = fSampling/2;

Ws = [fStop1 fStop2]/fNyquist;
Wp = [fPass1 fPass2]/fNyquist;

%% Design Butterworth Filter
[nB,WnB] = buttord(Wp,Ws,Rp,Rs)
[numB,denB] = butter(nB,WnB);

%% Design Chebyshev Type 2 Filter 
[nCh2,WnCh2] = cheb2ord(Wp,Ws,Rp,Rs)
[numCh2,denCh2] = cheby2(nCh2,Rs,WnCh2);

%% Design Elliptic Filter 
[nE,WnE] = ellipord(Wp,Ws,Rp,Rs)
[numE,denE] = ellip(nE,Rp,Rs,WnE);

%% Analyze and Compare Filters
fvtool(numB,denB,numCh2,denCh2,numE,denE);

%% Filter a noisy tune. 
% Load tune, plot spectrum, listen to tune, filter tune and listen and plot
% spectrum. 
x = wavread('myRecord.wav');
freqz(x,1,512,fSampling);
soundsc(x,fSampling);
y = filter(numE,denE,x);
figure;
freqz(y,1,512,fSampling);
soundsc(y,fSampling);
wavwrite(y,fSampling,'myRecordIIRFilter')