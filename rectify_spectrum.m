t=0.01:0.01:1;
x=sin(2*pi*3*t)+sin(2*pi*9*t)+sin(2*pi*15*t);
plot(t,x);figure
y=fftshift(fft(x));
z=ifft(fftshift(y));
f=linspace(-50,49);
plot(f,abs(y));figure(gcf)
xlim([-20 20])
set(gca,'XMinorTick','on')
% set(gca,'XTickLabel',-20:20)
grid on


x(x<0)=0;
figure
plot(t,x);figure;
y=fftshift(fft(x));
z=ifft(fftshift(y));
f=linspace(-50,49);
plot(f,abs(y));figure(gcf)
xlim([-20 20])
set(gca,'XMinorTick','on')
% set(gca,'XTickLabel',-20:20)
grid on