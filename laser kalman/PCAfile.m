A=[283 
273 
271 
276 
280 
279 
284 
277 
294 
298 
223 
248 
234 
249 
248 ]

[n,m]=size(A)
AMean=mean(A)
AStd=std(A)
B=(A-repmat(AMean,[n 1]))./repmat(AStd,[n 1])
B=zscore(A)
cov(B)
[V D]=eig(cov(B))
diag(D)
princomp(B)
[COEFF SCORE LATENT]=princomp(B)
B*COEFF
(B*COEFF)*COEFF'
((B*COEFF)*COEFF').*repmat(AStd,[15 1])+repmat(AMean,[n 1])

cumsum(var(SCORE))/sum(var(SCORE))
corrcoef(SCORE)
PC=B*V
var(PC)
[COEFF SCORE LATENT]=princomp(B)
%DATA COMPRESSION
Vreduced=V(:,3)
Vreduced=V(:,3)
PCReduced=B*Vreduced
PCReduced*Vreduced'
%Decompression
(PCReduced*Vreduced').*repmat(AStd,[n 1])+repmat(AMean,[n 1])
VDenoise=V;VDenoise(:,1)=0
VDenoise=VDenoise*VDenoise'
B*VDenoise
(PCReduced*Vreduced').*repmat(AStd,[n 1])+repmat(AMean,[n 1])