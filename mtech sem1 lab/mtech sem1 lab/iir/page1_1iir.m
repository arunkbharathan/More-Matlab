%MaxGain=0dB,MaxPassBandRipple,Rp=3dB,MinStopBandAtten,Rs=60dB
%PassEdgeFreq=2KHz,StopEdgeFreq=2.5Khz,Fsamp=8KHz.
clear
Fsamp=8000;Rp=3;Rs=60;Fp=2000;Fs=2500;
[n,Wn] = buttord(Fp/Fsamp,Fs/Fsamp,3,60)
[b,a] = butter(n,Wn);
[H,w]=freqz(b,a,1024);
mag=20*log10(abs(H));
phs=angle(H);
plot(w/pi*Fsamp/2,mag);title('magnitude spectrum');ylabel('in dB');figure;
plot(w/pi*Fsamp/2,(phs));title('phase spectrum');ylabel('Radians');figure
A=[.4 .3 .5 1];F=[1500;2000;3000;2600];
t=1/Fsamp:1/Fsamp:.1;
X=A*sin(2*pi*F*t);
plot(t(1:160),X(end-159:end));title('Input');figure
Y=filter(b,a,X);
plot(t(1:160),Y(end-159:end));title('output')