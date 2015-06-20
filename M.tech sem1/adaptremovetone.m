clc;clear
fsamp=8000;
A=[.3 .4 .2];F=[75;120;20];
t=1/fsamp:1/fsamp:2;
X=A*sin(2*pi*F*t);
plot(t,X);title('Input');


% wo = 50/(fsamp/2);  bw = 1/(fsamp/2);
% [b,a] = iirnotch(wo,bw);
% fvtool(a,b);

% noize=0.1*randn(1,length(t));
% tone=filter(a,b,noize);
tone=sin(2*pi*50*t);
Y=X+tone;

e=zeros(1,length(t));y=zeros(1,length(t));
x=tone;d=Y;
N=2;
W=zeros(1,N);
W=[1,.05];
mu=.008;
 for j=1:20
for i=N:length(x)
    y(i)=W*x(i:-1:i-(N-1))';
    e(i)=d(i)-y(i);
    W=W+mu*x(i:-1:i-(N-1))*e(i);
end
 end

soundsc(X,fsamp);
% soundsc(noize,fsamp);
% soundsc(tone,fsamp);

% soundsc(Y,fsamp);
soundsc(e,fsamp);

% soundsc(y,fsamp);


v=xcorr(tone,'biased');v=v(end-floor(end/2):end);
R=toeplitz(v(1:N));
1/max(eig(R))

% 0 < ? < 1/?max.,