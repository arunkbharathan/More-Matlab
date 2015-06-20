clc;clear;
j=imread('lena.jpg');
d=im2double(j);%converting from unsigned 8 bit to double because most of matlab functions work on double
x=d;
%experiment by giving different desired image(d) and input image(x)



% x=n;d=Y;
% y=zeros(1,length(t));e=zeros(1,length(t));
N=10;
W=zeros(1,N);

mu=.00001;
  for j=1:512
for i=N:512
    y(j,i)=W*x(j,i:-1:i-(N-1))';
    e(j,i)=d(j,i)-y(j,i);
    W=W+mu*x(j,i:-1:i-(N-1))*e(j,i);
end
  end
  
title('desired image')
  imshow(d);figure
title('input image')
imshow(x);figure
title('error image')
imshow(e);figure

imshow(y);title('adapted image')