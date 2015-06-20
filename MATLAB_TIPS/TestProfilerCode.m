A=rand(100,100);
 
h=waitbar(0,'Waiting...');
EndOfLoop=2000;
 tic
for i=1:EndOfLoop
A=A.^2;
waitbar(i/EndOfLoop,h);
end
toc
delete(h);

clear
A=rand(400,400,400);
B=A;
B(1,1,1)=0;
beep