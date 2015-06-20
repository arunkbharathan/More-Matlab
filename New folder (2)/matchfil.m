clc;clear
SNRindB1=0:1:12;
SNRindB2=0:0.1:12;
for i=1:length(SNRindB1)
    smlderrprb(i)=smldpe2(SNRindB1(i));

end

for i=1:length(SNRindB2)
    SNR=exp(SNRindB2(i)*log(10)/10);
   theoerrprb(i)=0.5*erfc(sqrt(SNR/2));
end
semilogy(SNRindB1,smlderrprb,'*');hold
semilogy(SNRindB2,theoerrprb);