clear all;
snrindB1=0:1:15;
snrindB2=0:0.1:15;
for i=1:length(snrindB1)
    smlderrprb=smldpe1(snrindB1(i));
end
for i=1:length(snrindB2)
    snr=exp(snrindB(i)*log10/10);
    theoerrprb=0.5*erfc(sqrt(snr/2));
end
figure;
semilogy(snrindB,smlderrprb,'*');
hold on
semilogy(snrindB,theoerrprb);
legend('simulation','theory');
xlabel('biterror performance');
ylabel('Eb/N0,dB');