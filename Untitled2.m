%#%$@@#@#$$%#%%%^*^&(*(*)*()^&^#$@@$##!~$%@
%Selection Diversity
EbN0Lin = 10.^(Eb_N0_dB/10);
theoryBer_nRx1 = 0.5.*(1-1*(1+1./EbN0Lin).^(-0.5)); 
% nRx=1 (theory)
theoryBer_nRx2 = 0.5.*(1-2*(1+1./EbN0Lin).^(-0.5) +    (1+2./EbN0Lin).^(-0.5)); % nRx=2 (theory)
 
%Equal Gain Combinig
theoryBer_nRx1 = 0.5.*(1-1*(1+1./EbN0Lin).^(-0.5)); 
% nRx=1 (theory)
theoryBer_nRx2=0.5*(1-sqrt(EbN0Lin.*(EbN0Lin+2))./(EbN0Lin+1)); % nRx=2
%Maximal ratio Combining
theoryBer_nRx1 = 0.5.*(1-1*(1+1./EbN0Lin).^(-0.5)); 
p = 1/2 - 1/2*(1+1./EbN0Lin).^(-1/2);
theoryBer_nRx2 = p.^2.*(1+2*(1-p)); 
%Rayleigh Fading
theoryBerAWGN = 0.5*erfc(sqrt(10.^(Eb_N0_dB/10))); % theoretical ber
EbN0Lin = 10.^(Eb_N0_dB/10);
theoryBer = 0.5.*(1-sqrt(EbN0Lin./(EbN0Lin+1)));
%#%$@@#@#$$%#%%%^*^&(*(*)*()^&^#$@@$##!~$%@