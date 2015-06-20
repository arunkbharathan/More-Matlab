Fsamp=8000;nFFT=512;
Amp=[.4 .3 .5 1];Freq=[1500;2000;3000;2600];
t=1/Fsamp:1/Fsamp:.1;
x=Amp*sin(2*pi*Freq*t);
y=fft(x,nFFT);
mag = abs(y);
phase = unwrap(angle(y))*180/pi;
Freso = Fsamp/nFFT;
fAxis = 0:Freso:Fsamp/2-Freso;
mag=mag/nFFT;
plot(fAxis,mag(1:256));grid;
title('Magnitude spectrum')
xlabel('Frequency F(Hz)')
ylabel('Magnitude')

figure
plot(fAxis,phase(1:256));grid
title('Phase spectrum')
xlabel('Frequency F(Hz)')
ylabel('Phase');