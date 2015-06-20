function message=despreading(code,start)
% the reverse of spreading function
% to decode bits
% three important parameters are used here. One is the feedback polynomial.
% I,ve taken it as [5 3]. And the second is further seed generation.
% I've given this unique expression (i-1)*13. The third is the seed %that
% comes from outside.
S=5;
Sd=2^S-1;
L=floor(length(code)/S);
states=zeros(L,S);
states(1:Sd,:)=prng(start,[5 3]);
for i=2:ceil(L/(Sd-1));
states(Sd*(i-1)+1:Sd*i,:)=prng(states((i-1)*13,:),[5 3]);
end
states=states(1:L,:);
data=zeros(1,L);
for i=1:L
if autocorr(code((i-1)*S+1:i*S),states(i,:))>=3
data(i)=0;
else if autocorr(code((i-1)*S+1:i*S),states(i,:))<=-3
data(i)=1;
else
data(i)='U';
end
end
end
data_array=zeros(floor(L/7),7);
for i=1:L/7
data_array(i,:)=data((i-1)*7+1:i*7);
end
c=char(data_array);
for i=1:L/7;
for j=1:7;
if data_array(i,j)==0
c(i,j)='0';
else
c(i,j)='1';
end
end
end
message=char(bin2dec(c)');
end