% not our problem just to refer


%% Designs a FIR Filter for the mid-high range of the five band equalizer.
%  The fir1 function which uses the window based design method is used with
%  a Hamming and Blackman window. 

close all
clear all

%% Set Analog Parameters
fPass1 = 2700;
fPass2 = 4300;
Rp = 1;
Rs = 60;

%% Normalize Frequencies with respect to Nyquist Frequency
fSampling = 22050;
fNyquist = fSampling/2;
Wp = [fPass1 fPass2]/fNyquist;

%% Design FIR Filter With default Hamming Window
numFIRHamm = fir1(127,Wp);

%% Design FIR Filter with Blackman Window
% Design Window
windowBlack = blackman(128);
numFIRBlack = fir1(127,Wp,windowBlack);

%% Analyze Filters
fvtool(numFIRHamm,1,numFIRBlack,1);

%% Filter a noisy tune. 
% Load tune, plot spectrum, listen to tune, filter tune and listen and plot
% spectrum.
x = wavread('myRecord.wav');
freqz(x,1,512,fSampling);
soundsc(x,fSampling);
y = filter(numFIRBlack,1,x);
figure;
freqz(y,1,512,fSampling);
soundsc(y,fSampling);
wavwrite(y,fSampling,'myRecordFIRFilter');
