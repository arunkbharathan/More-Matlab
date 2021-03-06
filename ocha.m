t=1:1000;
signal=sin(2*pi*0.055*t');
noise=randn(1,1000);
nfilt=fir1(11,0.4);
fnoise=filter(nfilt,1,noise); 
d=signal.'+fnoise;
coeffs = nfilt.' -0.01; 
mu = 0.05;         
ha = adaptfilt.sd(12,mu);
set(ha,'coefficients',coeffs);
[y,e] = filter(ha,noise,d);
subplot(2,2,1);
plot(signal(1:200));
subplot(2,2,2);
plot(e(1:200));

