x = imread('Lena.JPG');
imshow(x);
[A B C D] = dwt2(double(x),'db16');
imA = make_image(A);
imB = make_image(B);
imC = make_image(C);
imD = make_image(D);
[maxA_row maxA_col]=size(imA);
superx=zeros(maxA_row*2,maxA_col*2,'uint8');
% put the subimages in the 4 corner of superx matrix
superx(1:maxA_row,1:maxA_col) = imA;
superx(1:maxA_row,maxA_col+1:maxA_col*2)=imB;
superx(maxA_row+1:maxA_row*2,1:maxA_col)=imC;
superx(maxA_row+1:maxA_row*2,maxA_col+1:maxA_col*2)=imD;
imshow(superx);
title(' approximation coefficients and details coefficients');