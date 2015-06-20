function p = pitchperiod(fs,f0,blklen);
q=round(fs/f0);
w=[];
w(1)=1;
for i=2:blklen
    t=rem(i,q);
    if t==0
        w(i)=1;
    else
        w(i)=0;
    end
    p=w;
end