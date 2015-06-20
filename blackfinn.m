function v=blackfinn(u)
s=int32(u(1)*2^0+u(2)*2^8+u(3)*2^16);
if u(4)==45
    s=-s;
end
v=int32(s);