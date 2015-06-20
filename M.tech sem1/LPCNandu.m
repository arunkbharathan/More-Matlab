clc; 
% speech compression of a signal of sampling rate 7333Hz  with lpc-10 
%original signal speech_dft.wav has 22kHz sampling rate 
clear all; 
x1=wavread('speech_dft.wav'); % original signal speech_dft.wav has 22kHz sampling rate 
x2=x1(1:109920); clear x1; 
for i=1:36640 x1(i)=x2(i*3); end; clear x2; x2=x1; 
%wavplay(x2,7350); % signal with fs=7333kHz 
q=(max(x2)-min(x2))/256;x2q=round(x2/q)*q; 
x2=x2q; 
%wavplay(x2,7350); % signal with fs=7333kHz, quantized. 
clear x2q; 
% estimating sequence :analysis 
% signal is divided into subsequences, each 160 samples. 
for i=1:229 
    x3=x2(i*160-159:i*160); 
    a=lpc(x3,10); coefft(i,:)=a; 
    est_x3=(filter([0 -a(2:10)],1,x3)); 
    est_x2(i*160-159:i*160)=real(est_x3); 
end; 
%wavplay(est_x2,7350); % estimated signal with fs=7333 signal with fs=7333kHz. 
%SYNTHESISED SIGNAL 
noise=[zeros(1,160) ];noise(80)=1; 
b1=1; 
for i=1:229 
    a1= real(coefft(i,:)); 
    %noise=[1,zeros(1,159)]; 
    %noise=0.1*randn(1,160); 
    y1=filter(b1,a1,noise); 
    new_sig(i*160-159:i*160)=(y1); 
end; 
    wavplay(new_sig,7350); 