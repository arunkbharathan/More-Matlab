function barkscale=barkconversion(fs)
if fs==44100
barkscale=[1 4 6 9 11 14 17 20 23 27 31 35 41 47 55 64 76 90 107 127 150 178 214 267 360];
else
block=1024;
i=1:block/2;
fi=(i-1)*fs/block;
z=zeros(1,2);
barkscale=ones(1,26);
barklength=1;
z(1)=13*atan(0.76*fi(1)/1000)+3.5*atan((fi(1)/7500)*(fi(1)/7500));
for i=2:length(fi)
z(2)=13*atan(0.76*fi(i)/1000)+3.5*atan((fi(i)/7500)*(fi(i)/7500));
j=barklength;
if ((z(1)<j) && (j<=z(2)))
barkscale(barklength+1)=i;
barklength=barklength+1;
end
z(1)=z(2);
end
barkscale=barkscale(1:barklength);
end
end