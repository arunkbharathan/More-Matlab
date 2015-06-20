function steepdescent(R,P)
a=eig(R);
k=2/max(a);
sprintf('Input u less than %f',k)
meu =input('');
syms('w1','w2','x','y');
W1=zeros(1,50);
W2=zeros(1,50);
wn=[x;y];
w1=wn+meu*(P-R*wn);
w2=w1(2);
w1=w1(1);
W1(1)=subs(w1,{x,y},{0,0});
 W2(1)=subs(w2,{x,y},{0,0});
for i=1:49
    W1(i+1)=subs(w1,{x,y},{W1(i),W2(i)});
    W2(i+1)=subs(w2,{x,y},{W1(i),W2(i)});
end
t=0:49;
subplot(2,1,1)
plot(t,W1,'-*r');grid;set(gca,'XTick',0:1:49);title('W1');
subplot(2,1,2)
plot(t,W2,'-*b');grid;set(gca,'XTick',0:1:49);title('W2');
   