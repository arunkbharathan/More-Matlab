function detecting(seed)
% Function to detect watermark data from audio signal.
% The audio signal (in mono-wave format) is given as input
% seed is a 5-bit array that has atleast a 1, used as key for %encrytption
% The same seed that was ued for embedding has to be used for detection
close all;
S=5; %the spreading ratio 1:5
E=15; % maximum no.of embedded bits in each frame
SYC=[0 0 0 0 0 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 1 1 0 0 0 0 0 0 0];% synchronisation code
SL=length(SYC);
ML=8; % standard length of each character set
FL=7*S*ML+SL; % frame iteration standard length
%- x -> stores the sample values, fs -> stores the sampling frequency
[x,fs]=wavread(input('The audio file from which watermark is to be extracted (provide full path if not in working directory)'));
n=length(x); %stores the length of the audio signal
display('Sampling Frequency');display(fs);
display('Length');display(n);
% Now for synchronisation points.
y=x.^4;
tre=.15*max(y);
pos=find(y>tre);
poslen=length(pos);
maxsync=floor(poslen/1024);
syend=zeros(1,maxsync); % Store the end points
systrt=zeros(1,maxsync); % Store the start points
syncpoints=0;
frames=0;
for i=1:poslen-1 % FOR 1
if((pos(i+1)-pos(i))>1024) % IF 1 % finding symbol embedding %frames
syncpoints=syncpoints+1;
systrt(syncpoints)=pos(i); % Start points of symbol %embedding frame
syend(syncpoints)=pos(i+1); %end points of symbol embedding %frame
frames=frames+floor((pos(i+1)-pos(i))/1024);
end % END OF IF 1
end % END OF FOR 1
systrt=systrt(1:syncpoints);
syend=syend(1:syncpoints);
display('No. of synchronisation points');display(syncpoints);
display('No. of Frames');display(frames);
% Now the message to be decoded
bitstream=zeros(1,frames);
display('End of primary Computation');
%-- MAPPING BETWEEN FREQUENCY AND BARK SCALE (OPTIMISED LOOP AND %MEMEORY)--
barkscale=barkconversion(fs);
barklength=length(barkscale);
pz=zeros(1,barklength);
for j=2:barklength
pz(j-1)=barkscale(j)-barkscale(j-1);
end
pz(j)=513-barkscale(j);
display(barklength);
% basilar membrane spreading function
basilar=zeros(1,barklength);
if (rem(barklength,2)==1)
k_vals=-((barklength-1)/2):(barklength-1)/2;
else
k_vals=-((barklength)/2-1):barklength/2;
end
for i=1:barklength
basilar(i)=15.91+7.5*(k_vals(i)+0.474)- 17.5*sqrt(1+(k_vals(i)+0.474)^2);
end
% plot(basilar);title('Basilar Membrane');
% raw masking threshold
traw=zeros(1,barklength);
% normalized threshold
tnorm=zeros(1,barklength);
spz=zeros(1,barklength);
% Now to each frame.
framecount=0;
for i=1:syncpoints
framesnow=floor((syend(i)-systrt(i))/1024);
for j=0:framesnow-1
framecount=framecount+1;
frame=x((systrt(i)+1+j*1024):(systrt(i)+(j+1)*1024));
% fft of our frame
frame_fft=dit_fft(frame);
% power spectrum
powsp=abs(frame_fft).^2;
% display('upto power spectral density');
% energy per critical band Spz(z), i.e sum across each % %barkscale
spzproduct=1;
spzsum=0;
for p=1:barklength
spz(p)=0;
for q=barkscale(p):(barkscale(p)+pz(p)-1)
spz(p)=spz(p)+powsp(q);
end
spzproduct=spzproduct*spz(p);
spzsum=spzsum+spz(p);
end
% spectral flatness measure
SFMdb=10*log10(((barklength*spzproduct)/spzsum)^(1/barklength));
% Tonality factor
alpha=min(SFMdb/-60,1);
% Spread energy per critical band
smz=cconv(spz,basilar,barklength);
% Masking energy offset
oz=alpha*(14.5+(1:barklength))+(1-alpha)*5.5;
% display('upto energy offset');
% Raw Masking threshold & normalised masking threshold
embed_pos=zeros(1,E);
embedcount=0;
for p=1:barklength
traw(p)=10^(log10(abs(smz(p)))-(oz(p)/10));
tnorm(p)=traw(p)/pz(p);
%----------------------------------------------------------------------%
tnorm=tnorm/(abs(mean(smz))*abs(alpha)*5);
%----------------------------------------------------------------------%
for q=barkscale(p):(barkscale(p)+pz(p)-1)
if embedcount<E
if (powsp(q) < tnorm(p))
embedcount=embedcount+1;
embed_pos(embedcount)=q;
end
end
end
end
% Now to detect the bit
count=0;
for p=1:embedcount
if real(frame_fft(embed_pos(p)))<0
count=count+1;
else %real(frame_fft(embed_pos(k_1)))>0
count=count-1;
end
end
if count < 0
bitstream(framecount)=1;
else
bitstream(framecount)=0;
end
switch(framecount)
case floor(frames*0.1)
display('10 % completed');
case floor(frames*0.2)
display('20 % completed');
case floor(frames*0.3)
display('30 % completed');
case floor(frames*0.4)
display('40 % completed');
case floor(frames*0.5)
display('50 % completed');
case floor(frames*0.6)
display('60 % completed');
case floor(frames*0.7)
display('70 % completed');
case floor(frames*0.8)
display('80 % completed');
case floor(frames*0.9)
display('90 % completed');
case frames
display('100 % completed');
end
end
end
if frames<FL
display(despreading(bitstream,seed));
end
i=1;
while i<=frames-FL
count=autocorr(bitstream(i:i+SL-1),SYC);
if count>(SL-7)
display(despreading(bitstream(i+SL:i+FL-1),seed));
i=i+FL;
end
i=i+1;
end
end