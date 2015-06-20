t=1/8000:1/8000:1;
A=[1 2 3 4];
F=[500; 1000; 1500; 2500];
x=A*sin(2*pi*F*t);
plot(t,x);
figure;
plot(abs(fft(x,1024)));
n=randn(1,length(x));
d=x+n;
N=10;
W=zeros(1,N);
mu=.000008;
for i=N:length(x)
y(i)= W*x(i:-1:i-(N-1))';
e(i)= d(i)-y(i);
W=W+mu*x(i:-1:i-(N-1))*e(i);
end
plot(t,e);
plot(abs(fft(e,1024)));
figure; plot(abs(fft(x,1024)));