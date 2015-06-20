function [p]=smldpe3(SNRindB)
E=1;
SNR=10^(SNRindB/10);
sigma=E/sqrt(2*SNR);
N=1000000;

dsource=rand(1,N)>0.5+0;

numferr=0;

for i=1:N
    if (dsource(i)==0)
        r=-E+(sigma*randn);
    else
        r=E+sigma*randn;
    end
    
    if(r<0)
        d=0;
    else
        d=1;
    end
    if(d~=dsource(i))
        numferr=numferr+1;
    end
end
p=numferr/N;
end