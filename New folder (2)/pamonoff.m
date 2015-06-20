clc;clear
SNRindB1=0:1:15;
SNRindB2=0:0.1:15;
for i=1:length(SNRindB1)
    smlderrprb(i)=smldpe4(SNRindB1(i));

end

for i=1:length(SNRindB2)
    SNR=exp(SNRindB2(i)*log(10)/10);
   theoerrprb(i)=0.5*erfc(sqrt(SNR/4));
   
   
   
   
   
   
   
end
semilogy(SNRindB1,smlderrprb,'*');hold
semilogy(SNRindB2,theoerrprb);