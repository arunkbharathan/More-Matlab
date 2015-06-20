% not our problem just to refer

%% Generate a Sequence of Musical Notes.
% Musical notes corresponding to the second octave starting with the note
% Do or C at 524 Hz, and ending with the note Ti or at 988 Hz are generated
% for one second, weighted with an exponentially decaying signal to model
% the attack and decay of musical instruments and sent to the sound card.

clear all
close all

%% Chose sampling frequency 
fSampling = 4000;

%% Create time Vector
tSampling = 1/fSampling;
t = 0:tSampling:0.5;

%% Set of note frequencies
fNote = [524 588 660 698 784 880 988];

%% Generate notes
Do = sin(2*pi*fNote(1)*t+2*pi*rand);%C
Re = sin(2*pi*fNote(2)*t+2*pi*rand);%D
Mi = sin(2*pi*fNote(3)*t+2*pi*rand);%E 
Fa = sin(2*pi*fNote(4)*t+2*pi*rand);%F
So = sin(2*pi*fNote(5)*t+2*pi*rand);%G
La = sin(2*pi*fNote(6)*t+2*pi*rand);%A
Ti = sin(2*pi*fNote(7)*t+2*pi*rand);%B

%% Weigh the notes
expWtCnst = 6;
expWt = exp(-abs(expWtCnst*t));
Do = Do.*expWt;
Re = Re.*expWt;
Mi = Mi.*expWt;
Fa = Fa.*expWt;
So = So.*expWt;
La = La.*expWt;
Ti = Ti.*expWt;

%% Generate note sequence
noteSequence = [Do Re Mi Fa So La Ti];

%% Listen to Notes
soundsc(noteSequence,fSampling)

%% Spectral Analysis
% Set frequency analysis parameters
nFFT = 2^14;
tuneF = fft(noteSequence,nFFT);
magTune = abs(tuneF);
phaseTune = angle(tuneF);
phaseTune = unwrap(phaseTune);
fSpacing = fSampling/nFFT;
fAxis = -fSampling/2:fSpacing:fSampling/2-fSpacing;
magTune = fftshift(magTune);
phaseTune = fftshift(phaseTune);

plot(fAxis,20*log10(magTune));
xlabel('Frequency F(Hz)')
ylabel('Magnitude X(F)')

figure
plot(fAxis,phaseTune);
xlabel('Frequency F(Hz)')
ylabel('Phase X(F)')
%% plot spectrogram
% figure
spectrogram(noteSequence,256,0,[],fSampling)
