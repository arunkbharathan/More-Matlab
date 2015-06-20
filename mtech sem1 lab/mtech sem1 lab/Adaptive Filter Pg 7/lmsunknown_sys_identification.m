hn=[1 -1 .5 -.5 .2 .1 .1 ];
x=randn(1,1000);
d=filter(hn,1,x);
%note desired signal d and input signal x

N=7;%if more than 7 coefficients extra coefficients will be near to 0.
W=zeros(1,N);
mu=.1;
for i=N:length(x)
    y(i)=W*x(i:-1:i-(N-1))';
    e(i)=d(i)-y(i);
    W=W+mu*x(i:-1:i-(N-1))*e(i);
end

cla
 stem([hn;W(1:7)]');legend('hn','W')