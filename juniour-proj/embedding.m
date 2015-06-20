function embedding(seed)
% Function to watermark data into audio signal.
% The audio signal (in mono-wave format) and message (in character)is given
% as input
% seed is a 5-bit array that has atleast a 1, used as key for encrytption
% The same seed has to be used for detetion of watermark
close all;
S=5; %the spreading ratio 1:5
E=15; % maximum no.of embedded bits in each frame
SYC=[0 0 0 0 0 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 1 1 0 0 0 0 0 0 0];% synchronisation code
SL=length(SYC);
ML=8; % standard length of each character set
FL=7*S*ML+SL; % frame iteration standard length
%- x -> stores the sample values, fs -> stores the sampling frequency
[x,fs]=wavread(input('The audio file to be watermarked (provide full path if not in working directory)'));
n=length(x); %stores the length of the audio signal
display('Sampling Frequency');display(fs);
display('Length');display(n);
% Now for synchronisation points.
y=x.^4;
tre=0.15*max(y);
pos=find(y>tre);
poslen=length(pos);
syend=zeros(1,poslen); % Store the end points
systrt=zeros(1,poslen); % Store the start points
syncpoints=0;
frames=0;
for i=1:poslen-1 % FOR 1
if((pos(i+1)-pos(i))>1024) % IF 1 % finding symbol embeding frames
syncpoints=syncpoints+1;
systrt(syncpoints)=pos(i); % Start points of symbol embedding frame
syend(syncpoints)=pos(i+1); %end points of symbol embedding frame
frames=frames+floor((pos(i+1)-pos(i))/1024);
end % END OF IF 1
end % END OF FOR 1
systrt=systrt(1:syncpoints);
syend=syend(1:syncpoints);
display('No. of synchronisation points');display(syncpoints);
display('No. of Frames');display(frames);
% Now the message to be encoded
bitstream=zeros(1,frames);
message=input('The message to be watermarked(min 8 characters) ');
spaces=[' ' ' ' ' ' ' ' ' ' ' ' ' '];
remainder=rem(length(message),ML);
if (remainder)
spaces=spaces(1:ML-remainder);
message=[message spaces];
end % to add spaces to the end of message so as to make it's length a multiple of ML
if frames<FL
inputbitstream=spreading(message,seed);
bitstream=inputbitstream(1:frames);
else
pieces=length(message)/ML;
message_a=zeros(pieces,ML);
for i=1:pieces
message_a(i,:)=message((i-1)*ML+1:i*ML);
end
loop=floor(frames/FL);
for i=1:loop
j=rem(i,pieces);
if j==0
j=pieces;
end
bitstream((i-1)*FL+1:i*FL)=[SYC spreading(message_a(j,:),seed)];
end
end
display('End of primary Computation');
%-- MAPPING BETWEEN FREQUENCY AND BARK SCALE (OPTIMISED LOOP %AND MEMORY)--
barkscale=barkconversion(fs);
barklength=length(barkscale);
display(barklength);
pz=zeros(1,barklength);
for j=2:barklength
pz(j-1)=barkscale(j)-barkscale(j-1);
end
pz(j)=513-barkscale(j);
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
% energy per critical band Spz(z), i.e sum across each barkscale
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
%---------------------------------------------------------------------%
tnorm=tnorm/(abs(mean(smz))*abs(alpha)*5);
%---------------------------------------------------------------------%
for q=barkscale(p):(barkscale(p)+pz(p)-1)
if embedcount<E
if (powsp(q) < tnorm(p))
embedcount=embedcount+1;
embed_pos(embedcount)=q;
end
end
end
end
% Now to add data
if bitstream(framecount)
for p=1:embedcount
if real(frame_fft(embed_pos(p)))<0
frame_fft(embed_pos(p))=conj(frame_fft(embed_pos(p)))*-1;
frame_fft(rem(1025-embed_pos(p),1024)+1)=conj(frame_fft(rem(1025-embed_pos(p),1024)+1))*-1;
end
end
else
for p=1:embedcount
if real(frame_fft(embed_pos(p)))>0
frame_fft(embed_pos(p))=conj(frame_fft(embed_pos(p)))*-1;
frame_fft(rem(1025-embed_pos(p),1024)+1)=conj(frame_fft(rem(1025-embed_pos(p),1024)+1))*-1;
end
end
end
% back to time-domain in frame.
inverseframe=dit_ifft(frame_fft);
x((systrt(i)+1+j*1024):(systrt(i)+(j+1)*1024))=real(inverseframe);
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
wavwrite(x,fs,'output.wav');
display('Computation over');
end