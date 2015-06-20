%MaxGain=0dB,MaxPassBandRipple,Rp=3dB,MinStopBandAtten,Rs=60dB
%PassEdgeFreq=2KHz,StopEdgeFreq=2.5Khz,Fsamp=8KHz.
%if gain is normalised gain=1,Rp=3dB==1.4125,(20*log10(x/1)=3,find x)
%Similarly Rs=60dB,x=.001,(20*log10(1/x)=60)

fsamp = 8000;
fcuts = [2000 2500];
mags = [1 0];
devs = [1.4125 .001];

[n,Wn,beta,ftype]=kaiserord(fcuts,mags,devs,fsamp);
sprintf('Order=%d \n3dB Point=%f',n,Wn*fsamp/2)
hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
[H,f] = freqz(hh,1,1024,fsamp);
plot(f,abs(H)), grid on

A=[.4 .3 .5 1];F=[1500;2000;3000;2600];
t=1/fsamp:1/fsamp:.1;
X=A*sin(2*pi*F*t);
plot(t,X);title('Input');figure
Y=filter(hh,1,X);
plot(t,Y);title('output')