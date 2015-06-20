 j=imread('lena.jpg');
d=im2double(j);
x=d;
N=10;
W=zeros(1,N);
mu=0.001;
for i=1:512
for j=N:512
y(i,j)=W*x(i,j:-1:j-(N-1))';
e(i,j)= d(i,j)-y(i,j);
W=W+mu*x(i,j:-1:j-(N-1))*e(i,j);
end
end
imshow(d); figure; imshow(e);figure;imshow(y);