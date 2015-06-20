% Linear Prediction and Autoregressive Modeling 
data=data';
% fs=22050;
N=10;%no: of lpc coeffients
blklen=floor(fs*20e-3);
len=floor(length(data)/blklen)*blklen;
data=data(1:len);
blk=[1:blklen:length(data)];
Wk=zeros(N,length(blk));
k=1;fo=[];me=[];
tic
for i=blk
    x=data(i:i+blklen-1);  %segmented data
    corres=corrarun(x);%correlator output
    R=toeplitz(corres(1:N),corres(1:N));%constructing R(NxN) from corres(1xN)
    r=-corres(2:1+N)';
    Wk(:,k)=inv(R)*r;%a=Rinverse*r
    est_x3(i:i+blklen-1)=filter([-Wk(:,k)'],1,x);
    r = spCorr(x, fs, []);
f0(k) = round(spPitchCorr(r, fs));
me(k)=mean(x);
k=k+1;
end
toc
%soundsc(est_x3,fs);
Wk2=zeros(N+1,length(blk));k=1;
tic
for i=blk
    x=data(i:i+blklen-1);  %segmented data
    [Wk2(:,k) e(k)]=lpc(x,10);%a=Rinverse*r
    k=k+1;
end
toc

noise=.3633*randn(1,blklen);
k=1;
% for i=1:2 noise(i*80-79:i*80)=[1,zeros(1,79) ];end;
% noise=zeros(1,blklen);
% noise(round(blklen/2))=.2;noise(1)=0;

for i=1:size(blk,2)
 kk=filter(1,[1 Wk(:,k)'],noise);
recon1(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
%soundsc(recon1,fs)

noise=zeros(1,blklen);
noise(round(blklen/2))=.2;noise(1)=0;k=1;

for i=1:size(blk,2)
 kk=filter(1,[1 Wk(:,k)'],noise);
recon2(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
%soundsc(recon2,fs)

%soundsc(recon1+recon2,fs)

% [a e]=lpc(data,10);
% n=filter(1,a,data);
% soundsc(data,22050)
% soundsc(n,22050)
% m=filter(a,1,n);
k=1;
for i=1:size(blk,2)
    if e(k)>.0005
 kk=filter(1,[1 Wk(:,k)'],sqrt(e(k))*randn(1,blklen));
    else
       xxx = pitchperiod(fs,f0(k),blklen);
 kk=filter(1,[1 Wk(:,k)'],me(k)*xxx);
    end
recon3(blk(i):blk(i)+blklen-1)=kk;
k=k+1;
end
soundsc(recon3,fs)
% In the case of linear prediction, the intention is to determine an FIR filter that can optimally predict future samples of an autoregressive process based on a linear combination of past samples. The difference between the actual autoregressive signal and the predicted signal is called the prediction error. Ideally, this error is white noise.
% 
% For the case of autoregressive modeling, the intention is to determine an all-pole IIR filter, that when excited with white noise produces a signal with the same statistics as the autoregresive process that we are trying to model.
% 
