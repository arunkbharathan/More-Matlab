clc;clear
fsamp=8000;
A=[.3 .4 .2];F=[75;120;20];
t=1/fsamp:1/fsamp:10;
X=A*sin(2*pi*F*t);


tone=sin(2*pi*50*t);
Y=X+tone;

% e=zeros(1,length(t));y=zeros(1,length(t));
x=tone;d=Y;% note d and x (desired and input)
N=2;  %to remove a sine wave 2 coeffients are eonugh
W=[1 .05];
mu=.008;
 for j=1:20
for i=N:length(x)
    y(i)=W*x(i:-1:i-(N-1))';
    e(i)=d(i)-y(i);
    W=W+mu*x(i:-1:i-(N-1))*e(i);
end
 end
figure;

plot(t((1:4000)),Y(end-3999:end));title('Input');
figure
plot(t((1:4000)),e(end-3999:end));title('Output');