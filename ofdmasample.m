clc;clear;
K=10;N=2*K;T=100;
a=rand(1,36);
a=sign(a-0.5);
b=reshape(a,9,4);
%Generate 16 QAM points
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4));
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))];xt=zeros(1,101);%delta f= 1/20 hertz   (delta f=Fs/N)
%instead of below for loop take ifft(X,101)
for t=0:100
    for k=0:N-1
        xt(1,t+1)=xt(1,t+1)+1/sqrt(N)*X(k+1)*exp(j*2*pi*k*t/T); % since Fs=1, 1/1*100=100second duration
    end
end
xn=zeros(1,N);
%instead of below for loop take ifft(X,20)
for n=0:N-1
    for k=0:N-1
        xn(n+1)=xn(n+1)+1/N*X(k+1)*exp(j*2*pi*n*k/N);
    end
end
plot([0:100],abs(xt))
for n=0:N-1
    d(N+1)=xt(T/N*n+1)-xn(1+n);
end
e=norm(d);
Y=zeros(1,10);
for k=1:9
    for n=0:N-1
        Y(1,k+1)=Y(1,k+1)+1/N*xn(n+1)*exp(-j*2*pi*k*n/N);
    end
end
dd=Y(1:10)-X(1:10);
ee=norm(dd);


%Orthogonal
t=0:0.001:.5;
n=sin(4*pi*t).*sin(6*pi*t);sum(n)
%fs=100,N=100,deltaF=1 hertz;
X=[zeros(1,44) 3-1i 0 1-i 2 2-3i 0 0 0 2+3i 2 1+i 0 3+i zeros(1,43)];
sig=ifft(fftshift(X));
plot(sig)
x=fftshift(fft(sig))


%y=fft(x,N), x is of Fs, FD resolution is Fs/N
%z=ifft(y,W) z is of N/(W*Fs) spaced samples  som error chk later