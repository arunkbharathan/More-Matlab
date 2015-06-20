%==========================================================================
% The OFDM signal with channel noise for LTE Access Network
%==========================================================================
clear all
clc
close  all
%   ---------------
%   A: Setting Parameters
%   ---------------
nTx = 2;
nRx = 2;
M = 4;                          %   QPSK signal constellation
no_of_data_points = 64;        %   have 64 data points
block_size = 8;                 %   size of each ofdm block
cp_len = ceil(0.1*block_size);  %   length of cyclic prefix
no_of_ifft_points = block_size;           %   8 points for the FFT/IFFT
no_of_fft_points = block_size;
%   ---------------------------------------------
%   B:  %   +++++   TRANSMITTER    +++++
%   ---------------------------------------------
%   1.  Setup Initial Datasource
data_source_1 = randsrc(1, no_of_data_points, 0:M-1);
data_source_2 = randsrc(1, no_of_data_points, 0:M-1);
figure(1)
stem(data_source_1); grid on; xlabel('data points'); ylabel('transmitted data phase representation')
title('Transmitted Data "O 1"');figure
stem(data_source_2); grid on; xlabel('data points'); ylabel('transmitted data phase representation')
title('Transmitted Data "O 2"')
%   2.  Perform QPSK modulation
qpsk_modulated_data_1 = pskmod(data_source_1, M);
qpsk_modulated_data_2 = pskmod(data_source_2, M);
scatterplot(qpsk_modulated_data_1);title('qpsk modulated transmitted data_1')
scatterplot(qpsk_modulated_data_2);title('qpsk modulated transmitted data_2')
%   3.  Do IFFT on each block
%   Make the serial stream a matrix where each column represents a pre-OFDM
%   block (w/o cyclic prefixing)
%   First: Find out the number of colums that will exist after reshaping
num_cols=length(qpsk_modulated_data_1)/block_size;
data_matrix_1 = reshape(qpsk_modulated_data_1, block_size, num_cols);
data_matrix_2 = reshape(qpsk_modulated_data_2, block_size, num_cols);
%   Second: Create empty matix to put the IFFT'd data
cp_start = block_size-cp_len;
cp_end = block_size;

%   Third: Operate columnwise & do CP
for i=1:num_cols,
    ifft_data_matrix_1(:,i) = ifft((data_matrix_1(:,i)),no_of_ifft_points);
    ifft_data_matrix_2(:,i) = ifft((data_matrix_2(:,i)),no_of_ifft_points);
    %   Compute and append Cyclic Prefix
    for j=1:cp_len,
       actual_cp_1(j,i) = ifft_data_matrix_1(j+cp_start,i);
       actual_cp_2(j,i) = ifft_data_matrix_2(j+cp_start,i);
    end
    %   Append the cyclic prefix to the existing block to create the actual OFDM block
    ifft_data_1(:,i) = vertcat(actual_cp_1(:,i),ifft_data_matrix_1(:,i));
    ifft_data_2(:,i) = vertcat(actual_cp_2(:,i),ifft_data_matrix_2(:,i));
end

%   4.  Convert to serial stream for transmission
[rows_ifft_data cols_ifft_data]=size(ifft_data_1);
len_ofdm_data = rows_ifft_data*cols_ifft_data;

%   Actual OFDM signal to be transmitted
ofdm_signal_1 = reshape(ifft_data_1, 1, len_ofdm_data);
ofdm_signal_2 = reshape(ifft_data_2, 1, len_ofdm_data);
figure;
plot(real(ofdm_signal_1)); xlabel('Time'); ylabel('Amplitude');
title('OFDM Signal 1');grid on;
figure
plot(real(ofdm_signal_2)); xlabel('Time'); ylabel('Amplitude');
title('OFDM Signal 2');grid on;
%   ---------------------------------------------
%   B:  %   +++++  AWGN CHANNEL  & Rayleigh Channel  +++++ to create the noise channel
%   ---------------------------------------------
Eb_N0_dB=35;;%signal to noise ratio in dB
N=len_ofdm_data*2;

s = upsample(ofdm_signal_1,2)+circshift(upsample(ofdm_signal_2,2),[0,1]);%arranging [x1 y1 x2 y2...] for TX1 and TX2
%where x1 is ofdm_1 symbol and y1 is ofdm_2 symbol they are alternately
%arranged and transmitted throught tx1 and tx2 at same instant
sMod = kron(s,ones(nRx,1)); % 
    
    sMod = reshape(sMod,[nRx,nTx,N/nTx]); % grouping in [nRx,nTx,N/NTx ] matrix

    h = 1/sqrt(2)*[randn(nRx,nTx,N/nTx) + 1i*randn(nRx,nTx,N/nTx)]; % Rayleigh channel
    n = 1/sqrt(2)*[randn(nRx,N/nTx) + 1i*randn(nRx,N/nTx)]; % white gaussian noise, 0dB variance

    % Channel and noise Noise addition
    y = squeeze(sum(h.*sMod,2)) + 10^(-Eb_N0_dB/20)*n;
%h11,h12,h22,h21 ; TX1toRX1 + TX2toRX1;TX1toRX2 + TX2toRX2   at rx1;rx2
    % Receiver

    % Forming the MMSE equalization matrix W = inv(H^H*H+sigma^2*I)*H^H
    % H^H*H is of dimension [nTx x nTx]. In this case [2 x 2] 
    % Inverse of a [2x2] matrix [a b; c d] = 1/(ad-bc)[d -b;-c a]
    hCof = zeros(2,2,N/nTx)  ; 
    hCof(1,1,:) = sum(h(:,2,:).*conj(h(:,2,:)),1) + 10^(-Eb_N0_dB/10);  % d term
    hCof(2,2,:) = sum(h(:,1,:).*conj(h(:,1,:)),1) + 10^(-Eb_N0_dB/10);  % a term
    hCof(2,1,:) = -sum(h(:,2,:).*conj(h(:,1,:)),1); % c term
    hCof(1,2,:) = -sum(h(:,1,:).*conj(h(:,2,:)),1); % b term
    hDen = ((hCof(1,1,:).*hCof(2,2,:)) - (hCof(1,2,:).*hCof(2,1,:))); % ad-bc term
    hDen = reshape(kron(reshape(hDen,1,N/nTx),ones(2,2)),2,2,N/nTx);  % formatting for division
    hDen=hDen+eps;
    hInv = hCof./hDen; % inv(H^H*H)

    hMod =  reshape(conj(h),nRx,N); % H^H operation
    
    yMod = kron(y,ones(1,2)); % formatting the received symbol for equalization
    yMod = sum(hMod.*yMod,1); % H^H * y 
    yMod =  kron(reshape(yMod,2,N/nTx),ones(1,2)); % formatting
    yHat = sum(reshape(hInv,2,N).*yMod,1); % inv(H^H*H)*H^H*y
    
    
    recvd_signal_1=yHat(1:2:end);%seperating symbol 1 and 2 from recever estimate yHat
   recvd_signal_2=yHat(2:2:end);
   



figure
plot(real(recvd_signal_1),'b');title('received OFDM signal 1 with noise');grid
figure
plot(real(recvd_signal_2),'b');title('received OFDM signal 2 with noise');grid
%   ------------------------------------------
%   E:  %   +++++   RECEIVER    +++++
%   ------------------------------------------


%   4.  Convert Data back to "parallel" form to perform FFT
recvd_signal_matrix_1 = reshape(recvd_signal_1,rows_ifft_data, cols_ifft_data);
recvd_signal_matrix_2 = reshape(recvd_signal_2,rows_ifft_data, cols_ifft_data);

%   5.  Remove CP
recvd_signal_matrix_1(1:cp_len,:)=[];
recvd_signal_matrix_2(1:cp_len,:)=[];

%   6.  Perform FFT
for i=1:cols_ifft_data,
    %   FFT
    fft_data_matrix_1(:,i) = fft(recvd_signal_matrix_1(:,i),no_of_fft_points);
    fft_data_matrix_2(:,i) = fft(recvd_signal_matrix_2(:,i),no_of_fft_points);
end

%   7.  Convert to serial stream
recvd_serial_data_1 = reshape(fft_data_matrix_1, 1,(block_size*num_cols));
recvd_serial_data_2 = reshape(fft_data_matrix_2, 1,(block_size*num_cols));

%   8.  Demodulate the data
qpsk_demodulated_data_1 = pskdemod(recvd_serial_data_1,M);
qpsk_demodulated_data_2 = pskdemod(recvd_serial_data_2,M);
scatterplot(recvd_serial_data_1);title('qpsk modulated received data_1')
scatterplot(recvd_serial_data_2);title('qpsk modulated received data_2')
figure;
stem(qpsk_demodulated_data_1,'rx');
grid on;xlabel('data points');ylabel('received data phase representation');title('Received Data "X"')   
figure
stem(qpsk_demodulated_data_2,'kx');
grid on;xlabel('data points');ylabel('received data phase representation');title('Received Data "X"')   




