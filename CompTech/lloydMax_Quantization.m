 clc;clear;close all;
I = imread('pout.tif');
% I = imread('Lena.jpg');
[pixels,bri] =imhist(I+30);

b=0:32:255;
y=b+16;
b=b(2:end);
% 
% y=[16 48 80 112 143 175 207 239];
% b=[32 64 96 128 159 191 223];

x=bri;
% plot(bri,pixels,'r');hold
k=[b(1)*ones(1,256); b(2)*ones(1,256); b(3)*ones(1,256); b(4)*ones(1,256); ...
    b(5)*ones(1,256); b(6)*ones(1,256); b(7)*ones(1,256)];
kk=[y(1)*ones(1,256); y(2)*ones(1,256); y(3)*ones(1,256); y(4)*ones(1,256); ...
    y(5)*ones(1,256); y(6)*ones(1,256); y(7)*ones(1,256);y(8)*ones(1,256)];
% plot(k,bri,kk,bri)

h=createfigure1(bri, pixels, k(1,:), k(2,:), k(3,:), k(4,:), k(5,:), k(6,:), k(7,:), kk(1,:), kk(2,:), kk(3,:), kk(4,:), kk(5,:), kk(6,:), kk(7,:), kk(8,:));
hold
pixprob=pixels/prod(size(I));
tic
for t=1:50
y(y==0)=1;
b(b==0)=1;
b(1)=round((y(1)+y(2))/2);
y(1)=round(sum(x(1:b(1)).*pixprob(1:b(1)))/(sum(pixprob(1:b(1)))+eps));

b(2)=round((y(2)+y(3))/2);
y(2)=round(sum(x(b(1):b(2)).*pixprob(b(1):b(2)))/(sum(pixprob(b(1):b(2)))+eps));

b(3)=round((y(3)+y(4))/2);
y(3)=round(sum(x(b(2):b(3)).*pixprob(b(2):b(3)))/(sum(pixprob(b(2):b(3)))+eps));

b(4)=round((y(4)+y(5))/2);
y(4)=round(sum(x(b(3):b(4)).*pixprob(b(3):b(4)))/(sum(pixprob(b(3):b(4)))+eps));

b(5)=round((y(5)+y(6))/2);
y(5)=round(sum(x(b(4):b(5)).*pixprob(b(4):b(5)))/(sum(pixprob(b(4):b(5)))+eps));

b(6)=round((y(6)+y(7))/2);
y(6)=round(sum(x(b(5):b(6)).*pixprob(b(5):b(6)))/(sum(pixprob(b(5):b(6)))+eps));

b(7)=round((y(7)+y(8))/2);
y(7)=round(sum(x(b(6):b(7)).*pixprob(b(6):b(7)))/(sum(pixprob(b(6):b(7)))+eps));

y(8)=round(sum(x(b(7):255).*pixprob(b(7):255))/(sum(pixprob(b(7):255))+eps));


k=[b(1)*ones(1,256); b(2)*ones(1,256); b(3)*ones(1,256); b(4)*ones(1,256); ...
    b(5)*ones(1,256); b(6)*ones(1,256); b(7)*ones(1,256)];
kk=[y(1)*ones(1,256); y(2)*ones(1,256); y(3)*ones(1,256); y(4)*ones(1,256); ...
    y(5)*ones(1,256); y(6)*ones(1,256); y(7)*ones(1,256);y(8)*ones(1,256)];
% plot(k,bri,kk,bri)
drawnow;pause(.1)
h=createfigure2(bri, pixels, k(1,:), k(2,:), k(3,:), k(4,:), k(5,:), k(6,:), k(7,:), kk(1,:), kk(2,:), kk(3,:), kk(4,:), kk(5,:), kk(6,:), kk(7,:), kk(8,:),h);


end
toc
legend('Imhist','Thresh')
% 
% k=[b(1)*ones(1,256); b(2)*ones(1,256); b(3)*ones(1,256); b(4)*ones(1,256); ...
%     b(5)*ones(1,256); b(6)*ones(1,256); b(7)*ones(1,256)];
% kk=[y(1)*ones(1,256); y(2)*ones(1,256); y(3)*ones(1,256); y(4)*ones(1,256); ...
%     y(5)*ones(1,256); y(6)*ones(1,256); y(7)*ones(1,256);y(8)*ones(1,256)];
% % plot(k,bri,kk,bri)
% 
% createfigure1(bri, pixels, k(1,:), k(2,:), k(3,:), k(4,:), k(5,:), k(6,:), k(7,:), kk(1,:), kk(2,:), kk(3,:), kk(4,:), kk(5,:), kk(6,:), kk(7,:), kk(8,:))

% p(1)=sum(counts(counts<32)) ;
% p(2)=sum(counts(counts>31 & counts<64));
% p(3)=sum(counts(counts>63 & counts<96));
% p(4)=sum(counts(counts>95 & counts<128));
% p(5)=sum(counts(counts>127 & counts<160));
% p(6)=sum(counts(counts>159 & counts<192));
% p(7)=sum(counts(counts>191 & counts<224));
% p(8)=sum(counts(counts>223)) ;
% 
% p=p/prod(size(I));