j=imread('untitled.jpg');
j=rgb2gray(j);
d=im2double(j);
% [c e]=lpc(d,50);
% for i=1:512
% x(:,i)=filter(sqrt(e(i)),c(i,:),randn(512,1));
% end
% imshow(x);%figure;imshow(d)
j=imread('untitled2.jpg');
x=rgb2gray(j);
x=im2double(x);
N=512;

for i=1:294
v=xcorr(x(i,:),'biased');
v=v(end-floor(end/2):end);
b=xcorr(d(i,:),x(i,:),'biased');
r=b(end-floor(end/2):end);
r=r(1:N);
R=toeplitz(v(1:N));
W(:,i)=inv(R)*r';
poi(i,:)=filter(W(:,i),1,x(i,:));
end
imshow(fliplr(W'));figure
imshow(x);figure;imshow(poi);




