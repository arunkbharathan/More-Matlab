close all;
t=0.01:0.01:1;
y=-1.01:.01:3;
x=[sawtooth(2*pi*.75*(-1.01:0.01:1)) fliplr(sin(2*pi*1*t)) cos(2*pi*1.5*t)];
fgh=[y;x];
ObjTrack(fgh)
beep