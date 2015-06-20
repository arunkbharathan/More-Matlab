function[p]=smldpe8(SNRindB)
E=1;
SNR=10^(SNRindB/10);
sigma=E/sqrt(2*snr);
N=100000;
numferr=0;
dsourse=rand(1,N)>0.5;
for i=1:N
    if(dsourse(i)==0)
        r0=E+sigma*rand;
        r1=sigma*rand;
    else
        r0=sigma*rand;
        r1=E+sigma*rand;
    end
    if(r0>r1)
        d=0;
    else
        d=1;
    end
    if(d~=dsourse)
        
        numferr=numferr+1;
    end
    p=numferr/N;
end