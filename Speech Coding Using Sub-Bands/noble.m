%sub band coding using noble identities for decimation and interpolation
%author: Rao Farhat Masood

close all;
clear all;
num=18000;
[x,fs] = wavread('e:\proj\myvoice',num);
x=x(:,1)';
lnx=length(x);
L = 2; 
len  = 25;   
wc = 1/L; %cut-off frequency is pi/2.
freq=-pi:2*pi/(lnx-1):pi;% the frequency vector 
lp = fir1(len-1, wc,'low');
hp = fir1(len-1, wc,'high');
%============================================================================
%decimating the signals first
ydl=x(1:2:lnx);
ydh=x(2:2:lnx);
%Now convolving 
yl=conv(ydl,lp);
yh=conv(ydh,hp);
%===================
%Again decimating Yl and Yh in 2nd stage
s0=yl(1:2:end);
s1=yl(2:2:end);

s2=yh(1:2:end);
s3=yh(2:2:end);

% now finally convolving to get the four bands
b0 =conv(yl,lp);
b1=conv(yl,hp);
b2 =conv(yh,lp);
b3=conv(yh,hp);

%=============================================================================
% Time domain plots of signal and filters
 figure(1); 
 subplot(311);
 plot(x);axis([0 lnx min(x) max(x)]);ylabel('speech=x');
 Title('Speech and decimated bands in time ');
 subplot(312);
 plot(ydl),ylabel('ydl');axis([0 length(ydl) min(ydl) max(ydl)]);
 subplot(313);
 plot(ydh),ylabel('ydh');axis([0 length(ydh) min(ydh) max(ydh)]);
 pause
 %================================================================
 %filters in time
 figure(2);
 subplot(211);
 stem(lp);axis([0 length(lp) (min(lp)+0.1) (max(lp)+0.1)]);
 ylabel('lp');title('Filters in time');
 subplot(212);
 stem(hp);axis([0 length(hp) min(hp)+0.1 max(hp)+0.1]);
 ylabel('hp');
 pause
%==============================================================================
%plotting filter response of filters and the two speech bands(lower and upper) in freq domian
figure(3);
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
pause
%=================================================================
%freq plots of decimated signals(four bands)
figure(4);
title('Four bands in freq domain');
subplot(411);
plot(freq/pi,abs(fftshift(fft(b0,lnx))));ylabel('|B0|');axis([0 pi/pi min(abs(fft(b0))) max(abs(fft(b0)))]);title('Four bands in freq domain');
subplot(412);
plot(freq/pi,abs(fftshift(fft(b1,lnx))));ylabel('|B1|');axis([0 pi/pi min(abs(fft(b0))) max(abs(fft(b1)))]);
subplot(413);
plot(freq/pi,abs(fftshift(fft(b2,lnx))));ylabel('|B2|');axis([0 pi/pi min(abs(fft(b2))) max(abs(fft(b2)))]);
subplot(414);
plot(freq/pi,abs(fftshift(fft(b3,lnx))));ylabel('|B3|');axis([0 pi/pi min(abs(fft(b3))) max(abs(fft(b3)))]);
pause;

%=================================================================
%Listening to decimation results                            
%wavplay(x,fs);
% wavplay(b0,fs/2);
% wavplay(b1,fs/2);
% wavplay(b2,fs/2);
% wavplay(b3,fs/2);
%===================================================================
% now synthesizing  
%reconstruction filters
L=2;
hr = L*fir1(len-1, wc,'low');
% hp = L*fir1(len-1, wc,'high');

Sso=conv(b0,hr);
Ss1=conv(b1,hr);
Ss2=conv(b2,hr);
Ss3=conv(b3,hr);

N1=length(Sso);
sb0=zeros(1,L*N1);
sb1=zeros(1,L*N1);
sb2=zeros(1,L*N1);
sb3=zeros(1,L*N1);

sb0(L:L:end)=Sso;
sb1(L:L:end)=Ss1;
sb2(L:L:end)=Ss2;
sb3(L:L:end)=Ss3;
%=================================================


Slow=sb0-sb1;
Shigh=sb2-sb3;

sub1=conv(hr,Slow);
sub2=conv(hr,Shigh);

subll=zeros(1,length(sub1)*2);
subhh=zeros(1,length(sub2)*2);

subll(L:L:end)=sub1;
subhh(L:L:end)=sub2;



sub=subll-subhh;
%================================================================
%Freq plots of final two bands and their merging into a single band

figure(5);
subplot(311);
plot(freq/pi,abs(fftshift(fft(subll,lnx))));ylabel('|low band|');axis([0 pi/pi min(abs(fft(subll))) max(abs(fft(subll)))]);title('Final two bands in synthesis');
subplot(312);
plot(freq/pi,abs(fftshift(fft(subhh,lnx))));ylabel('|High band|');axis([0 pi/pi min(abs(fft(subhh))) max(abs(fft(subhh)))]);
subplot(313);
plot(freq/pi,abs(fftshift(fft(sub,lnx))));ylabel('|Band|');axis([0 pi/pi min(abs(fft(sub))) max(abs(fft(sub)))]);
pause;
%============================================================
%Comparison
figure(6);
subplot(211), 
plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);title('Comparison');
legend('original band');
subplot(212);
plot(freq/pi,abs(fftshift(fft(sub,lnx))),'r');ylabel('|Band|');axis([0 pi/pi min(abs(fft(sub))) max(abs(fft(sub)))]);
legend('Synthesized Band');

%=====================================================================
%wavplay(sub,fs);

%wavplay(sub,fs);
% fs1=fs/4;
% wavwrite(b0,fs1,nbits,'bandn0');
% wavwrite(b1,fs1,nbits,'bandn1');
% wavwrite(b2,fs1,nbits,'bandn2');
% wavwrite(b3,fs1,nbits,'bandn3');
% wavwrite(sub,fs,nbits,'nobl');



