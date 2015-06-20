Fsamp=8000;

A=[.4 .3 .5 1];F=[1500;2000;3000;2600];
t=1/Fsamp:1/Fsamp:.1;
X=A*sin(2*pi*F*t);
Y=X+sin(2*pi*50*t);

Wp = [45 55]/(Fsamp/2); Ws = [40 60]/(Fsamp/2);
Rp = 3; Rs = 40;
[n,Wn] = buttord(Wp,Ws,Rp,Rs);
[b,a] = butter(2,Wn,'stop');
freqz(b,a,512,Fsamp)
title('Filter Response')
out=filter(b,a,Y);
figure
plot(t(400:800),Y(400:800));title('Input')
figure
plot(t(400:800),out(400:800));title('Output')