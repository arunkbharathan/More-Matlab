% to know more search this in matlab help "Linear Prediction and Autoregressive Modeling"
clc;clear
[data fs]=wavread('speech_dft.wav');data=data';
% fs=22050;
N=10;%no: of lpc coeffients
blklen=160;
len=floor(length(data)/blklen)*blklen;
data=data(1:len);      %7th and 6th lines truncates data to a multiple of 160
blk=[1:blklen:length(data)];% blk=1 161 321 481.......end of data
Wk=zeros(N,length(blk));
%below linear prediction with &without lpc function is done, the time
%required to solve both is displayed in command window ,lpc is faster
%because it implemnts levinson derbin
k=1;
tic
for i=blk
    x=data(i:i+blklen-1);  %segmented data
    %see the function corrlasion();
    corres=corrlasion(x);%correlator output;instead we can use builtin command xcorr(x,'biased')
    R=toeplitz(corres(1:N),corres(1:N));%constructing R(NxN) from corres(1xN)
    r=-corres(2:1+N)';%adding minus gives Wk otherwise a
    Wk(:,k)=inv(R)*r;%a=Rinverse*r
    est_x(i:i+blklen-1)=filter([-Wk(:,k)'],1,x);%passing data segment through prediction filter(FIR)to get estimated signal
    k=k+1;
end
toc
error=data-est_x;%estimation or prediction error
plot(error(1200:1400));title('prediction error');axis([0 200 -1.5e-3 1.5e-3]);grid

soundsc(est_x,fs);
Wk2=zeros(N+1,length(blk));k=1;%now the above steps is done with built in function lpc
tic
for i=blk
    x=data(i:i+blklen-1);  %segmented data
    [Wk2(:,k) e(k)]=lpc(x,10);%a=Rinverse*r, lpc gives noise varience of data segment also
    k=k+1;
end
toc



noise=zeros(1,blklen);
noise(160)=1;
noise(80)=1;k=1;  %this gives voiced (pitch period must me obtained to get correct pitch)not done here

for i=1:size(blk,2)
 kk=filter(1,[1 Wk(:,k)'],noise);
recon2(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
soundsc(recon2,fs)


k=1;
for i=1:size(blk,2)
 kk=filter(1,[1 Wk(:,k)'],sqrt(e(k))*randn(1,blklen));%use the noise variance from lpc to generate unvoiced sounds
recon3(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
soundsc(recon3,fs)
%refer www.data-compression.com
% In the case of linear prediction, the intention is to determine an FIR filter that can optimally predict future samples of an autoregressive process based on a linear combination of past samples. The difference between the actual autoregressive signal and the predicted signal is called the prediction error. Ideally, this error is white noise.
% 
% For the case of autoregressive modeling, the intention is to determine an all-pole IIR filter, that when excited with white noise produces a signal with the same statistics as the autoregresive process that we are trying to model.
% 
