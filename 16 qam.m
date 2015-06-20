%% Setup
% Define parameters.
M = 16; % Size of signal constellation
k = log2(M); % Number of bits per symbol
n = 3e4; % Number of bits to process = 30,000
Fd=1;Fs=1; %Input message sampling frequency, output message sampling
% frequency
nsamp = 1; % Oversampling rate
%% Signal Source
% Create a binary data stream as a column vector.
x = randint(n,1); % Random binary data stream
% Plot first 40 bits in a stem plot.
stem(x(1:40),'filled');
title('Random Bits');
xlabel('Bit Index'); ylabel('Binary Value')

%% Bit-to-Symbol Mapping
% Convert the bits in x into k-bit symbols.
xsym = bi2de(reshape(x,k,length(x)/k).','left-msb');
%% Stem Plot of Symbols
% Plot first 10 symbols in a stem plot.
figure; % Create new figure window.
stem(xsym(1:10));
title('Random Symbols');
xlabel('Symbol Index'); ylabel('Integer Value');


%% Modulation
% Modulate using 16-QAM.
y = dmodce(xsym,Fd,Fs, 'qask',M);


%% Transmitted Signal
ytx = y;
%% Channel
% Send signal over an AWGN channel.
EbNo = 10; % In dB
snr = EbNo + 10*log10(k) - 10*log10(nsamp);
ynoisy = awgn(ytx,snr,'measured');
%% Received Signal
yrx = ynoisy;


%% Scatter Plot
% Create scatter plot of noisy signal and transmitted
% signal on the same axes.
h = scatterplot(yrx(1:nsamp*5e3),nsamp,0,'g.');
hold on;
scatterplot(ytx(1:5e3),1,0,'k*',h);
title('Received Signal');
legend('Received Signal','Signal Constellation');
axis([-5 5 -5 5]); % Set axis ranges.
hold off;

%% Demodulation
% Demodulate signal using 16-QAM.
zsym = ddemodce(yrx,Fd,Fs, 'qask', M);
2.7

%% Symbol-to-Bit Mapping
% Undo the bit-to-symbol mapping performed earlier.
z = de2bi(zsym,'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z = reshape(z.',prod(size(z)),1);

%% BER Computation
% Compare x and z to obtain the number of errors and
% the bit error rate.
[number_of_errors,bit_error_rate] = biterr(x,z)


M = 16;
x = [0:M-1];
Fd=1;Fs=1;
scatterplot(dmodce(x,1,1,'qask',M));


% % % Include text annotations that number the points.
% % text(realdmodce(x,1,1,'qask',M))+0.1,imag(dmodce(x,1,1,'qask',M)),dec2bin(dmodce(x,1,1,'qask',M));
% % axis([-4 4 -4 4]); % Change axis so all labels fit in plot
% 
% %% Transmitted Signal
% % Upsample and apply square root raised cosine filter.
% ytx = rcosflt(y,1,nsamp,'filter',rrcfilter);
% 
% % Create eye diagram for part of filtered signal.
% eyediagram(ytx(1:2000),nsamp*2);
% 
% 
% %% Scatter Plot
% % Create scatter plot of received signal before and
% % after filtering.
% h = scatterplot(sqrt(nsamp)*ynoisy(1:nsamp*5e3),nsamp,0,'g.');
% hold on;
% scatterplot(yrx(1:5e3),1,0,'kx',h);
% title('Received Signal, Before and After Filtering');
% legend('Before Filtering','After Filtering');
% axis([-5 5 -5 5]); % Set axis ranges.
% 
