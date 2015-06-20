clc;close all;clear
I = imread('pout.tif');
I=histeq(I);
imshow(I)
for k=7:-1:0
n=bitsrl(I,k);
(8-k)
m=bitsll(n,k);figure
dell=2*128/2^(8-k);
m=m+dell/2;
imshow(m)
mmse=sum((double(m(:))-double(I(:))).^2)/prod(size(m))
(dell^2)/12
end
