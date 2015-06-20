clc;clear;
fs=30;L=1024;
t=0.001:1/fs:1/fs*L;

for f=1:15
x=0.5*sin(2*pi*f*t)+.5;
for i=1:512
v(i,:)=x;
end
v=im2uint8(v);
drawnow; pause(.5)
imshow(v)
clear v;
end