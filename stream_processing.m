%matlabpool open 2
clc
%%
h=dsp.AudioFileReader('Filename','I:\Documents and Settings\Arun\My Documents\My Music\wav\Podi.WAV');
h.SamplesPerFrame=1024;
p=dsp.AudioPlayer;
k=int16(zeros(1024,2));
plot(k(:,1));
axis([1 1024 -6000 6000])
hold;
grid on;
%set(u,'EraseMode','xor','MarkerSize',18)


%%

while ~h.isDone
    
k=step(h);
v=k(:,1);
step(p,k);
plot(v,'-r','LineWidth',1);
drawnow;
cla;

end