data=data(1:length(data)-rem(length(data),10));
a = reshape(data,10,length(data)/10)';

[n m]=size(a);
AMean=mean(a);
AStd=std(a);
B=zscore(a);
[COEFF SCORE LATENT]=princomp(B);
% SCORE=fliplr(SCORE);
% COEFF=fliplr(COEFF);
cumsum(var(SCORE))/sum(var(SCORE))
corrcoef(SCORE);
%DATA COMPRESSION
Vreduced=COEFF(:,1:5);

PCReduced=B*Vreduced;
Bdash=PCReduced*Vreduced';
%Decompression
adash=(Bdash).*repmat(AStd,[n 1])+repmat(AMean,[n 1]);

VDenoise=COEFF;VDenoise(:,7:10)=0;
PCDenoise=B*VDenoise;
Bdash=PCDenoise*VDenoise';
adash2=(Bdash).*repmat(AStd,[n 1])+repmat(AMean,[n 1]);

b= adash';
b=b(:);
soundsc(b,fs)
b= adash2';
b=b(:);
 soundsc(b,fs)
%  soundsc(data,fs)
%DATA REDUCTION AND DENOISING BY Principal Component Analysis