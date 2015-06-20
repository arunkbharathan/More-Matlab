%familiar with matlab image commands
J=imread('Lena.jpg');
I=im2double(J); %converting from unsigned 8 bit to double because most of matlab functions work on double
NEG=imadjust(I,[],[1 0]);%brightness level between eg:- 30&40 is altered to 100&200, the [highvalu lowvalu] gives negative of image 
imshow(I);title('original lena');figure;
imshoW(NEG);title('negative lena');figure;
imshow(I,[.50 .80]);title('brightness compressed lena');figure;
[counts x]=imhist(J);
stem(x,counts);axis([0 255 0 2500]);figure
imhist(J)
K=histeq(J);figure
imhist(K,64);figure
imshow(K);title('hist equalised lena');figure;
imshow(histeq(NEG,2));title('Black&White inverted lena');figure
imshow(histeq(J,2));title('Black&White lena');