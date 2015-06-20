Fsamp=8000;nFFT=512;
Amp=[.4 .3 .5 1];Freq=[1500;2000;3000;2600];
t=1/Fsamp:1/Fsamp:.1;
X=Amp*sin(2*pi*Freq*t);
plot(t,X);title('Mix of Sines');grid
x=X(1:512);
y=fft(x,nFFT);

mag = abs(y);
phase = angle(y);
phase = unwrap(phase);
fSpacing = Fsamp/nFFT;
fAxis = -Fsamp/2:fSpacing:Fsamp/2-fSpacing;
mag = fftshift(mag);
phase = fftshift(phase);figure

plot(fAxis,mag);grid;
xlabel('Frequency F(Hz)')
ylabel('Magnitude X(F)')

figure
plot(fAxis,phase);grid
xlabel('Frequency F(Hz)')
ylabel('Phase X(F)')

x=ifft(y,nFFT)
plot(t(1:512),x);