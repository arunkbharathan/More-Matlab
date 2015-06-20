function [out_value]=autocorr(a,b)
if length(a)>length(b)
    b=[b zeros(1,length(a)-length(b))];
else if length(b)>length(a)
    a=[a zeros(1,length(b)-length(a))];
    end
end
N=length(a);
out_value=0;
for i=1:N
    if a(i)==b(i)
        out_value=out_value+1;
    else
        out_value=out_value-1;
    end
end
end



