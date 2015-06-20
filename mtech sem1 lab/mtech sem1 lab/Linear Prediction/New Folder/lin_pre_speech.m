% to know more search this in matlab help "Linear Prediction and Autoregressive Modeling"
clc;clear;
sec=10;fs=8000;
data=wavrecord(sec*fs,fs)';
% fs=22050;
n=length(data);
numCoeff=10;%no: of lpc coeffients
blklen=160;
N=floor(n/blklen)*blklen;
data=data(1:N);      %7th and 6th lines truncates data to a multiple of 160
blk=1:blklen:length(data);%blk=1 161 321 481.......end of data

%below linear prediction with &without lpc function is done, the time
%required to solve both is displayed in command window ,lpc is faster
%because it implemnts levinson derbin

tic
 i=31841;
    x=data(i:i+blklen-1);  %segmented data
    %see the function corrlasion();
    cnt = length(x);
for ii=1:cnt
    corres(ii) = x(1:cnt-ii+1)*(x(ii:cnt))'/cnt;
end;%correlator output;instead we can use builtin command xcorr(x,'biased')
    R=toeplitz(corres(1:numCoeff));%constructing R(NxN) from corres(1xN)
    r=-corres(2:1+numCoeff)';
    Wk1=(inv(R)*r)'%Wk1 is a(=Rinverse*-r)
    toc
  
    tic
 i=31841;
    x=data(i:i+blklen-1);  %segmented data
     Wk2=Levinson_Durbin(x,10)%see Levinson_durbin function
toc
    
tic
 i=31841;
    x=data(i:i+blklen-1);  %segmented data
    Wk3=lpc(x,10)%a=Rinverse*r, lpc gives noise varience of data segment also
toc
i=31841;
for numCoeff=6:20
     x=data(i:i+blklen-1);  %segmented data
    [Wk e(numCoeff-5)]=lpc(x,numCoeff);%a=Rinverse*r, lpc gives noise varience of data segment also
end

stem(6:20,e,'k');clear e;
title('Prediction Error')
xlabel('Number of Coefficients')
k=1;%now the above steps is done with built in function lpc
tic
for i=blk
    x=data(i:i+blklen-1);  %segmented data
    [Wk4(:,k) e(k)]=lpc(x,10);%a=Rinverse*r, lpc gives noise varience of data segment also
    k=k+1;
end
toc



imptrn(160)=1;
imptrn(80)=1;k=1;  %this gives voiced (pitch period must me obtained to get correct pitch)not done here

for i=1:length(blk)
 kk=filter(1,Wk4(:,k)',imptrn);
recon1(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
soundsc(recon1,fs)


k=1;
for i=1:length(blk)
 kk=filter(1,Wk4(:,k)',sqrt(e(k))*randn(1,blklen));%use the noise varience from lpc to generate unvoiced sounds
recon2(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
soundsc(recon2,fs)
%refer www.data-compression.com
% In the case of linear prediction, the intention is to determine an FIR filter that can optimally predict future samples of an autoregressive process based on a linear combination of past samples. The difference between the actual autoregressive signal and the predicted signal is called the prediction error. Ideally, this error is white noise.
% 
% For the case of autoregressive modeling, the intention is to determine an all-pole IIR filter, that when excited with white noise produces a signal with the same statistics as the autoregresive process that we are trying to model.
% 
