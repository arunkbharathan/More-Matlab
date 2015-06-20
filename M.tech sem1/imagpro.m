J=imread('lena.jpg');
I=im2double(J);
NEG=imadjust(I,[],[1 0]);
imshow(I);figure;
imshoW(NEG);figure;
imshow(I,[.50 .80]);figure
[counts x]=imhist(J);
stem(x,counts);axis([0 255 0 2500]);figure
imhist(J)
K=histeq(J);figure
imhist(K,64);figure
imshow(K);figure;
imshow(histeq(NEG,2));figure;%BlackWhite
imshow(histeq(J,2));