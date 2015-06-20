function [p]=smldPe2(SNRindB)
E=1;
SNR=10^(SNRindB/10);
sgma=E/sqrt(2*SNR);
N=10000;
dsource=rand(1,N)>0.5;
numferr=0;
for i=1:N
    if(dsource(i)==0)
        ro=E+(sgma*randn);
        r1=(sgma*randn);
    else
        ro=(sgma*randn);
        r1=E+(sgma*randn);
    end
    if(ro>r1)
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