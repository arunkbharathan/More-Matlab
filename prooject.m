clc;clear;
drum=wavrecord(5*8000,8000);
pause(5)
disp('start')
voice=wavrecord(5*8000,8000);
%load('echocancelfile'); %loads drum(from distant mic to speaker here) voice(mic(here) to distant speaker)
b = firls(10,[0 0.25 0.3 1],[0 1 1 0]);%to filter drum by simulating room or atmosphere
d=filter(b,1,drum*2);%filter after increasing amplitude of drum 
sound(drum,8000)%play drum
%sound(d,8000)%play filtered drum d which is picked up by mic
sound(d+voice,8000);%what mic picks up is played
N=10;
W=zeros(1,N);
mu=0.1;
tft=d+voice;
drum=drum';
for i=N:length(drum)
    y(i)=W*drum(i:-1:i-(N-1))';
    e(i)=tft(i)-y(i);
    W=W+mu*drum(i:-1:i-(N-1))*e(i);
end
%sound(y,8000)%signal frm adaptive filter by varriying coefficients. to cancel out d
sound(e,8000)%d-y=e is sent to listener at other side
