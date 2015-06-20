function code=spreading(message,start)
% function to spread the message. Using an LFSR PRNG(pseudorandom %numbergenerator)
% The message input of character format is converted into ASCII value %and
% in binary. Then each bit is XORed with S bits generated from PRNG.
% to encode bits
% three important parameters are used here. One is the feedback %polynomial.
% Here taken as [5 3]. And the second is further seed generation.
% Here this unique expression (i-1)*13. The third is the seed that
% comes from outside.
data_array=dec2bin(message,7);
[a1,a2]=size(data_array);
data=ones(1,a1*a2);
for i=1:a1
for j=1:a2
if data_array(i,j)=='0'
data((i-1)*a2+j)=0;
end
end
end
S=5;
Sd=2^S-1;
states=zeros(a1*a2,S);
states(1:Sd,:)=prng(start,[5 3]);
for i=2:ceil(a1*a2/(Sd-1));
states(Sd*(i-1)+1:Sd*i,:)=prng(states((i-1)*13,:),[5 3]);
end
states=states(1:a1*a2,:);
for i=1:a1*a2;
code((i-1)*S+1:i*S)=xor(data(i),states(i,:));
end
end