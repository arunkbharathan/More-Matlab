x1=[ones(1000,1) ;zeros(2000,1)];
x2=[ones(2000,1) ;zeros(1000,1)];
x3=[zeros(1000,1) ;ones(2000,1)];
x4=ones(3000,1); %Input Signals
subplot(221)
plot(x1,'r');
subplot(222)
plot(x2,'r')
subplot(223)
plot(x3,'r')
subplot(224)
plot(x4,'r')
A=[x1 x2 x3 x4];
[Q R]=aurtho(A,0.001); %Orthogonal signals
figure;
subplot(221)
plot(Q(:,1),'r');
subplot(222)
plot(Q(:,2),'r');
subplot(223)
plot(Q(:,3),'r');
subplot(224)
plot(Q(:,4),'r')
