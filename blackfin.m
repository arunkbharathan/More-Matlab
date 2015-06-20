function u=blackfin(v)
if v>=0
    s=uint8('+');
else
    s=uint8('-');
end
v=abs(v);
v=typecast(v,'uint8');
v(4)=[];
v=[v s];
u=v;