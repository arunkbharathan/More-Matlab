close all;
clear all;
num=36000;
[x,fs,nbits] = wavread('sub1.wav',num);
x=x(:,1)';
lnx=length(x);
L = 2; 
len  = 25;   
wc = 1/L; %cut-off frequency is pi/2.
freq=-pi:2*pi/(lnx-1):pi;% the frequency vector 
lp = fir1(len-1, wc,'low');
hp = fir1(len-1, wc,'high');
yl=conv(x,lp);
yh=conv(x,hp);
%=============================================================================
%Time domain plots of signal and filters
 figure(1); 
 subplot(311);
 plot(x);axis([0 lnx min(x) max(x)]);ylabel('speech');
 title('Speech and filters in time domain');
 subplot(312);
 stem(lp);axis([0 length(lp) (min(lp)+0.1) (max(lp)+0.1)]);
 ylabel('lp');
 subplot(313);
 stem(hp);axis([0 length(hp) min(hp)+0.1 max(hp)+0.1]);
 ylabel('hp');

%==============================================================================
%plotting filter response of filters and the two speech bands(lower and upper) in freq domian
figure(2);
X=fftshift(fft(x,lnx));
Lp=fftshift(fft(lp,lnx));
Hp=fftshift(fft(hp,lnx));
YL=fftshift(fft(yl,lnx));
Yh=fftshift(fft(yh,lnx));
subplot(321), plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);title('Freq domain representation of speech and the two bands');
subplot(323), plot(freq/pi, abs(Lp),'g');ylabel('|Lp|');axis([0 pi/pi  min(abs(Lp)) max(abs(Lp))]);
subplot(324), plot(freq/pi, abs(Hp), 'g');ylabel('|Hp|');axis([0 pi/pi min(abs(Hp)) max(abs(Hp))]);
subplot(325), plot(freq/pi, abs(YL), 'y');ylabel('|YL|');axis([0 pi/pi min(abs(YL)) max(abs(YL))]);legend('Low bandafter filtering');
subplot(326), plot(freq/pi, abs(Yh), 'y');ylabel('|Yh|');axis([0 pi/pi min(abs(Yh)) max(abs(Yh))]);legend('High band after filtering');

%===================

ydl =yl(1:2:length(yl));
ydh=yh(1:2:length(yh));

s0=conv(ydl,lp);
s1=conv(ydl,hp);

s2=conv(ydh,lp);
s3=conv(ydh,hp);
% now finally decimating to get the four bands
b0 =s0(1:2:length(s0));
b1=s1(1:2:length(s1));
b2 =s2(1:2:length(s2));
b3=s3(1:2:length(s3));
%=================================================================
%freq plots of decimated signals(four bands)
figure(3);
title('Four bands in freq domain');
subplot(411);
plot(freq/pi,abs(fftshift(fft(b0,lnx))));ylabel('|B0|');axis([0 pi/pi min(abs(fft(b0))) max(abs(fft(b0)))]);title('Four bands in freq domain');
subplot(412);
plot(freq/pi,abs(fftshift(fft(b1,lnx))));ylabel('|B1|');axis([0 pi/pi min(abs(fft(b0))) max(abs(fft(b1)))]);
subplot(413);
plot(freq/pi,abs(fftshift(fft(b2,lnx))));ylabel('|B2|');axis([0 pi/pi min(abs(fft(b2))) max(abs(fft(b2)))]);
subplot(414);
plot(freq/pi,abs(fftshift(fft(b3,lnx))));ylabel('|B3|');axis([0 pi/pi min(abs(fft(b3))) max(abs(fft(b3)))]);


%=================================================================
%Listening to decimation results                            
%wavplay(x,fs);
% wavplay(b0,fs/2);
% wavplay(b1,fs/2);
% wavplay(b2,fs/2);
% wavplay(b3,fs/2);
%===================================================================
% now synthesizing   
L=2;
N1=length(b0);
Ss0=zeros(1,L*N1);
Ss1=zeros(1,L*N1);
Ss2=zeros(1,L*N1);
Ss3=zeros(1,L*N1);

Ss0(L:L:end)=b0;
Ss1(L:L:end)=b1;
Ss2(L:L:end)=b2;
Ss3(L:L:end)=b3;

%=================================================
%Passing through  reconstruction filters
% making a low pass filter with cutoff at 1/L and gain L
 reconst_fil=L*fir1(len-1,1/L);
% finding the freq response of the filter
sb0=conv(reconst_fil,Ss0);
sb1=conv(reconst_fil,Ss1);
sb2=conv(reconst_fil,Ss2);
sb3=conv(reconst_fil,Ss3);

Slow=sb0-sb1;
Shigh=sb2-sb3;

subl=zeros(1,length(Slow)*2);
subh=zeros(1,length(Shigh)*2);

subl(L:L:end)=Slow;
subh(L:L:end)=Shigh;

subll=conv(reconst_fil,subl);
subhh=conv(reconst_fil,subh);

sub=subll-subhh;
%================================================================
%Freq plots of final two bands and their merging into a single band

figure(4);
subplot(311);
plot(freq/pi,abs(fftshift(fft(subll,lnx))));ylabel('|low band|');axis([0 pi/pi min(abs(fft(subll))) max(abs(fft(subll)))]);title('Final two bands in synthesis');
subplot(312);
plot(freq/pi,abs(fftshift(fft(subhh,lnx))));ylabel('|High band|');axis([0 pi/pi min(abs(fft(subhh))) max(abs(fft(subhh)))]);
subplot(313);
plot(freq/pi,abs(fftshift(fft(sub,lnx))));ylabel('|Band|');axis([0 pi/pi min(abs(fft(sub))) max(abs(fft(sub)))]);

%============================================================
%Comparison
figure(5);
subplot(211), 
plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);title('Comparison');
legend('original band');
subplot(212);
plot(freq/pi,abs(fftshift(fft(sub,lnx))),'r');ylabel('|Band|');axis([0 pi/pi min(abs(fft(sub))) max(abs(fft(sub)))]);
legend('Synthesized Band');

%=====================================================================
%wavplay(x,fs);pause
%wavplay(sub,fs);
% fs1=fs/4;
% wavwrite(b0,fs1,nbits,'band0');
% wavwrite(b1,fs1,nbits,'band1');
% wavwrite(b2,fs1,nbits,'band2');
% wavwrite(b3,fs1,nbits,'band3');
% wavwrite(sub,fs,nbits,'sub1');




