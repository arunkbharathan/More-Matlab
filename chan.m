clear;
N=10^6;
ip=rand(1,N)>0.5;
s=2*ip-1;
Eb_N0_dB=[-3:35]
for i=1:length(Eb_N0_dB)
    h=1/sqrt(2)*[randn(1,N)+j*randn(1,N)];
    n=1/sqrt(2)*[randn(1,N)+j*randn(1,N)];
    y=h.*s+10^(-Eb_N0_dB(i)/20)*n;
    yHat=y./h;
    ipHat=real(yHat)>0;
    nErr(i)=size(find(ip-ipHat),2);
end
simberr=nErr/N;

gausschannelber=0.5*erfc(10.^(Eb_N0_dB/10));

EbN0Lin=10.^(Eb_N0_dB/10);
theoberr=0.5.*(1-sqrt(EbN0Lin./(EbN0Lin+1)));
close all
semilogy(Eb_N0_dB,simberr,'*');hold
semilogy(Eb_N0_dB,gausschannelber);
semilogy(Eb_N0_dB,theoberr,'r');
axis([-3 35 10^-5 0.5])
legend('Rayleigh-simulated','AWGN channel', 'Rayleigh Theory');
xlabel('Eb/N0,dB');
ylabel('BER');
title('BER performance of BPSK modulation');

