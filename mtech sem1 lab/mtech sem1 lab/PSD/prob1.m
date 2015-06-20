clc;clear;close all
fs=100;nFFT=512;
t=1/fs:1/fs:10;
A=[1 1];F=[15;30];
y=A*sin(2*pi*F*t);



y1=fft(y,nFFT);
f=fs*(0:(nFFT-1)/2)/nFFT;
power=y1.*conj(y1)/nFFT;
plot(f,power(1:end/2));title('Periodogram using fft');figure
ryy=xcorr(y,'biased');
Ryy=abs(fft(ryy,nFFT));
plot(f,Ryy(1:end/2));title('DFT of ACF')

figure
[Pxx w]=periodogram(y,[],'onesided',nFFT,fs);
plot(w,Pxx);title('Using Periodogram Function')
figure;
[Pxx w] = pwelch(y,[],[],nFFT,fs);
plot(w,Pxx);title('Using pwelch Function')

figure;
[Pxx w] = pyulear(y,10,nFFT,fs);
plot(w,Pxx);title('Using Pyulear Function')

figure;
[Pxx w] = pburg(y,10,nFFT,fs);
plot(w,Pxx);title('Using Pburg Function')