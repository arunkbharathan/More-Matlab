%familiar with matlab image commands
clc;clear
J=imread('Lena.JPG');
imshow(J);title('Original Image')
L=histeq(J);figure
imshow(L);title('Equalised Image')