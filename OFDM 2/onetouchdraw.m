%a1=[12 21 32 41 51;14 23 34 42 52;15 24 0 43 0;0 25 0 0 0];
 a1=[12 21 32 43 53 61 71 81;16 23 34 45 54 64 72 82;17 27 35 46 56 65 73 0;18 28 37 0 0 67 76 0]
for j=1: (size(a1,1)*size(a1,2))
a=a1;U=0;
if(a(j)~=0)
c=a(j);
else 
    continue
end
% d=((c-(rem(c,10)))/10); x=length(a1)*10+d;
B=[c]
while(sum(sum(a))~=0)
a(a==c)=0
a(a==(rem(c,10)*10+ ((c-(rem(c,10)))/10)))=0
if(sum(sum(a))==0)
    break;
end
I=rem(c,10);

for k=1:size(a,1)
if(a(k,I)~=0)
  c=a(k,I);
U=1;
% if(rem(c,10)==d & I~=length(a1))
%     U=0;
% end

end
if(U==1)
    U=0;
    break
end
end
B=[B c]
if(B(end)==B(end-1))
    break
end

end
end



