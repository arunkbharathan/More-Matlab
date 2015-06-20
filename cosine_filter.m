% Matlab program to design cosine modulated filter bank using 
% Kaiser window approach. For details see
%  Y-P. Lin and P. P. Vaidyanathan,
% ``A Kaiser window approach for the design of prototype filters of 
% cosine modulated filter banks'',  
% {  IEEE  Signal Proc. Letters,} vol. 5, 1998. 


clear;

M=32; 
As=100;
deltaf=.44;
N=floor((As-7.95)/14.36*M/deltaf);
fprintf(1,strcat('The order of the prototype:   ',num2str(N)))

df=(As-7.95)/14.36/N;
if As>=50,
   b=0.1102*(As-8.7);
else
   b=0.5842*(As-21)^0.4+0.07886*(As-21);
end

x1=0.55/M;x2=0.6/M;
dx=(x2-x1)/200;
x=x1; 
phi_min=1000;j=1;

while x<x2
  w1(j)=x;
  p0=fir1(N,x,kaiser(N+1,b));

  g0=conv(p0,p0);
  temp=g0(N+1:-2*M:1);
  phi(j)=max(abs(temp(2:length(temp))))/temp(1);

  if phi(j)<phi_min, phi_min=phi(j);
     w_min=x; 
  end
  x=x+dx; j=j+1;
end

p0=fir1(N,w_min,kaiser(N+1,b));
ws=(df+w_min)*M;

fprintf(1,'\n')
fprintf(1,'The minimum of the objective function:  ')
fprintf(1,num2str(phi_min,'%.3e'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot of objective function v.s. the cutoff freq.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle1=axes('position',[.4 .8 .3 .14]);
plot(w1,phi)
ylabel('\phi_{New}          ','Rotation',0)
xlabel('Cutoff freq. \omega_c (Freq. normalized by \pi)')
xlim=[.55/M .60001/M];
set(handle1,'XLim',xlim,'XTick',[.55/M:.0125/M:.6/M])
set(handle1,'YLim',[0 .06],'YTick',[0:.02:.06])

  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot of the magnitude response of the prototype filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle2=axes('position',[.4 .45 .3 .14]);
N1=256;[h,w]=freqz(p0,1,N1*M/2);
h=abs(h);
plot(w/pi,20*log10(h));
ylabel('dB        ','Rotation',0)
xlabel('Freq. normalized by \pi')
axis([0 1 -180 10])
set(handle2,'XTick',[0:.2:1],'YTick',[-180:60:10]);
title2=title('Magnitude response |P(e^{j\omega})| (in dB)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Zoom plot of the magnitude response of the prototype filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle3=axes('position',[.4 .1 .3 .14]);
plot(w(1:N1)/pi,20*log10(h(1:N1)));
ylabel('dB        ','Rotation',0)
xlabel('Freq. normalized by \pi')
axis([0 2/M -180 10])
set(handle3,'YTick',[-180:60:10]);
title2=title('Zoom plot of |P(e^{j\omega})| (in dB)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute the distortion function and the total aliasing distortion%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
h=zeros(M,N+1);
f=zeros(M,N+1);

for k=0:M-1
    for n=0:N
        h(k+1,n+1)=2*p0(n+1)*cos(pi/M*(k+0.5)*(n-N/2)+(-1)^k*pi/4);
        f(k+1,N+1-n)=h(k+1,n+1);    
    end
 end   
 
a=zeros(M,2*N+1);
for m=0:M-1
     for k=0:M-1
        a(m+1,:)=a(m+1,:)+conv(h(k+1,:).*exp(-i*[0:N]*2*pi*m/M),f(k+1,:));
     end
end

a0=zeros(1,1024);
for m=2:M
    a0=a0+(abs(fft(a(m,:),1024))/M).^2; 
end
a0=sqrt(a0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot the distortion function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(2); handle4=axes('position',[.4 .7 .3 .14]);
[h,w]=freqz(a(1,:),1,N1*M/2); plot(w(1:N1/2)/pi,abs(h(1:N1/2)));
set(handle4,'XLim',[0 1/M]);
set(handle4,'YLim',[.9971 1.002],'YTick',[.998:.001:1.002])
xlabel('Freq. normalized by \pi')
title4=title('M|T(e^{j\omega})|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot the total aliasing distortion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle5=axes('position',[.4 .2 .3 .14]);
plot([0:1/512:1],a0(1:513));
xlabel('Freq. normalized by \pi')
title5=title('Total aliasing distortion as defined in Eq. (8.2.10) in PPs book');
set(title5,'position',[.5 6*10^(-7) 0])