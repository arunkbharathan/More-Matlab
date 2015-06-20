% k=sort(round(rand(1,500)*5000))';
% p=1;
% for i=1:499
% if(k(i)==k(i+1))
% b(p)=i;p=p+1;
% end
% end
c=500;
path(path, './Optimization');
load('random500.mat');
k=sort(k);
%k=randperm(500)';
t=1/40000:(1/40000):(1/8);figure;
f=sin(2*pi*512*t)+sin(2*pi*1294*t);plot(t,f);title('original signal');f=f';
b=f(k);figure;plot(t(1:500),b,'r');title('random 500 measurements');grid
p=dct(f);figure;
plot(p(1:500));grid;title('dct');
D=idct(eye(5000,5000));
A=D(k,:);
result=A\b;figure;
plot(result(1:500));grid;title('A\b');
result1=pinv(A)*b;figure;
plot(result1(1:500));grid;title('Min Energy l2 minimization');
x0=A'*b;
xp = l1eq_pd(x0, A, [], b, 1e-2);figure;
plot(xp(1:500));grid;title('l1 minimization');
%sound(f);sound(dct(result));sound(dct(result1));sound(dct(x0));sound(f);sound(dct(xp));
figure;
plot(t(2000:2250),f(2000:2250));title('Original Signal');grid
figure;
vv=dct(result1);
plot(t(2000:2250),vv(2000:2250));title('L2 Reconstruction');grid
figure;
tt=dct(xp);
plot(t(2000:2250),tt(2000:2250));title('L1 Reconstruction');grid