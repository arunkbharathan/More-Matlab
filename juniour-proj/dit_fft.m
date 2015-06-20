function x = dit_fft(x)
N=1024;
A=10 ; %no of levels
x = bitrevorder(x); %perform bit-reversal
level = A;
phase = cos(2*pi/N*[0:(N/2-1)])-1i*sin(2*pi/N*[0:(N/2-1)]);
for a = 1:level
L = 2^a;
phase_level = phase(1:N/L:(N/2));
for k = 0:L:N-L
for n = 0:L/2-1
first = x(n+k+1);
second = x(n + k + L/2 +1)*phase_level(n+1);
x(n+k+1) = first + second;
x(n+k + L/2+1) = first - second;
end
end
end