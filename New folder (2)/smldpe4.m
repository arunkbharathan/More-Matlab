function [p]=smldpe4(SNRindB)
E=1;
SNR=10^(SNRindB/10);
sigma=E/sqrt(2*SNR);
N=100000;

dsource=rand(1,N)>0.5+0;

numferr=0;

for i=1:N
    if (dsource(i)==0)
        r=(sigma*randn);
    else
        r=E+sigma*randn;
    end
    
    if(r<0.5)
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