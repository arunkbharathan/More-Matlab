clc;close all;clear
x=[2.5 0.5 2.2 1.9 3.1 2.3 2 1 1.5 1.1]'
y=[ 2.4 0.7 2.9 2.2 3.0 2.7 1.6 1.1 1.6 0.9]'
xbar=x-mean(x)
ybar=y-mean(y)
RoDataAdj=[xbar ybar];
createfigure(x,y);
axis([-2.5 2.5 -2.5 2.5])
C=cov(xbar,ybar)
[eigval eigvec]=eig(C)
xx=[-2.5:.5:2.5];
yy1=eigval(1,1)/eigval(2,1)*[-2.5:.5:2.5];
yy2=eigval(2,1)/eigval(2,2)*[-2.5:.5:2.5];
createfigure1(xbar,ybar,xx,yy1,yy2)
%largest eigen value vector
RoFeaVec= circshift(eigval, [0, 1]);%eigval;%(:,2)
FinData=RoFeaVec*RoDataAdj'
plot(FinData(1,:),FinData(2,:))