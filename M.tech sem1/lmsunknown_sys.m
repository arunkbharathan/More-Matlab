hn=[1 -1 .5 -.5 .2 .1 .1 .8 -.1 -1];
xn=randn(1,1000);
un=filter(hn,1,xn);
freqz(hn,1,512);

y=zeros(1,length(xn));
e=zeros(1,length(xn));
N=10;
W=zeros(1,N);
mu=.1;
for i=N:length(xn)
    y(i)=W*xn(i:-1:i-(N-1))';
    e(i)=un(i)-y(i);
    W=W+mu*xn(i:-1:i-(N-1))*e(i);
end
figure
freqz(W,1,512);figure
 stem(hn,W)