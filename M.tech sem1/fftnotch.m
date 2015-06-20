clc;clear%interp(data,2);
[data fs]=wavread('doreminoisyTune');
freqz(data,1,512,4000)

nFFT = 2^nextpow2(length(data));
y=fft(data,nFFT);
mag = abs(y);
phase = angle(y);
phase = unwrap(phase);
fSpacing = fs/nFFT;
fAxis = -fs/2:fSpacing:fs/2-fSpacing;
mag = fftshift(mag);
phase = fftshift(phase);
plot(fAxis,20*log10(mag));grid;
xlabel('Frequency F(Hz)')
ylabel('Magnitude X(F)')
figure
plot(fAxis,phase);grid
xlabel('Frequency F(Hz)')
ylabel('Phase X(F)');
soundsc(data,fs);
y(32768-15000:32768+15000)=0;
mag = abs(y);
phase = angle(y);
phase = unwrap(phase);
fSpacing = fs/nFFT;
fAxis = -fs/2:fSpacing:fs/2-fSpacing;
mag = fftshift(mag);
phase = fftshift(phase);
plot(fAxis,20*log10(mag));grid;
xlabel('Frequency F(Hz)')
ylabel('Magnitude X(F)')
figure
plot(fAxis,phase);grid
xlabel('Frequency F(Hz)')
ylabel('Phase X(F)')

recon = real(ifft(y,nFFT));
soundsc(recon,fs);

wo=1400/2000;
bw=10/2000
[b,a] = iirnotch(wo,bw);

x=filter(b,a,data);
soundsc(x,fs)