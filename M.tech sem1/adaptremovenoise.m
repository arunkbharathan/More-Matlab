clc;clear
fsamp=8000;
A=3;F=1200;
t=1/fsamp:1/fsamp:2;
X=A*sin(2*pi*F*t);
% plot(t,X);title('Input');
n=1*randn(1,length(t));
coeff=fir1(8,0.4); % Eighth order lowpass filter
noize=filter(coeff,1,n);
Y=X+noize;

x=n;d=Y;
y=zeros(1,length(t));e=zeros(1,length(t));
N=10;
W=zeros(1,N);

mu=.001;
  for j=1:2
for i=N:length(x)
    y(i)=W*x(i:-1:i-(N-1))';
    e(i)=d(i)-y(i);
    W=W+mu*x(i:-1:i-(N-1))*e(i);
end
  end

soundsc(Y,fsamp)
soundsc(e,fsamp)
soundsc(y,fsamp);