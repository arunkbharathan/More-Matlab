clc;clear
fs=8000;sec=5;
t=1/fs:1/fs:sec;
data=wavrecord(sec*8000,8000)';
data=data+3*sin(2*pi*50*t);

nFFT = 2^nextpow2(length(data));
y=fft(data,nFFT);
mag = abs(y)/nFFT;
plot(mag,'k'); %find the components of 50 hertz from the graph
title('find 50 hertz components from graph');
figure 
soundsc(data,fs);
y(1:500)=0;y(end-499:end)=0;% removing the tone components from the freq domain
                           % remove equally from both sides otherwise ifft
                            % will give complex signals
mag = abs(y)/nFFT;
phase = unwrap(angle(y));
fSpacing = fs/nFFT;
fAxis = -fs/2:fSpacing:fs/2-fSpacing;
mag = fftshift(mag);
phase = fftshift(phase);
plot(fAxis,mag,'k');
title('Magnitude Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

recon = real(ifft(y,nFFT));
soundsc(recon,fs);