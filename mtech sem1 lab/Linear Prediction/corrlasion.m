% clc;clear;%instead use this-->v=xcorr(x,'biased');v=v(end-floor(end/2):end)
% x=[6 5 4 3 2 1];
function [result]=corrlasion(x)
r=zeros(1,length(x));
N=length(x);
for k=1:N
 for n=1:(N-k+1)
r(k)=(x(n)*x(n+k-1))+r(k);
end
r(k)=1/N*r(k);%1/(N-k+1)*r(k);=biased
end
result=r;
%lpc(x,4)==levinson(r,4) both give Wk(= -a)