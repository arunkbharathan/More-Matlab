snr1=0:12;
snr2=0:.1:12;
n=10^6;
e=1;
b=randn(1,n)>0.5;

for i=1:length(snr1)
snrq=10^(snr1(i)/10);
bert(i)=.5*erfc(sqrt(snrq));
end
c=0;

for i=1:length(snr2)
snrp=10^(snr2(i)/10);
si=e/sqrt(2*snrp);
for k=1:n
if (b(k)==0)
r(k)=-e+(randn*si);
else
r(k)=e+(randn*si);
end
if( r(k)>0)
br(k)=1;
else
br(k)=0;
end
if (br(k)~=b(k))
    c=c+1;
end
end
berp(i)=c/n;
end
semilogy(snr1,bert);
legend('ber plot theoretical')
figure
semilogy(snr2,berp);
legend('ber plot practical')

