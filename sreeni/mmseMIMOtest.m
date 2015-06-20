clear;ii=1;Eb_N0_dB=35;
nTx = 2;
nRx = 2;
N=1000;
t=.001:.001:.5;
A=sin(2*pi*2*t);
B=sawtooth(2*pi*4*t);
% Transmitter
    plot(t,A,t, B)
s = upsample(A,2)+circshift(upsample(B,2),[0,1]);

    sMod = kron(s,ones(nRx,1)); % 
    
    sMod = reshape(sMod,[nRx,nTx,N/nTx]); % grouping in [nRx,nTx,N/NTx ] matrix

    h = 1/sqrt(2)*[randn(nRx,nTx,N/nTx) + 1i*randn(nRx,nTx,N/nTx)]; % Rayleigh channel
    n = 1/sqrt(2)*[randn(nRx,N/nTx) + 1i*randn(nRx,N/nTx)]; % white gaussian noise, 0dB variance

    % Channel and noise Noise addition
    y = squeeze(sum(h.*sMod,2)) + 10^(-Eb_N0_dB(ii)/20)*n;
%h11,h12,h22,h21 ; TX1toRX1 + TX2toRX1;TX1toRX2 + TX2toRX2   at rx1;rx2
    % Receiver

    % Forming the MMSE equalization matrix W = inv(H^H*H+sigma^2*I)*H^H
    % H^H*H is of dimension [nTx x nTx]. In this case [2 x 2] 
    % Inverse of a [2x2] matrix [a b; c d] = 1/(ad-bc)[d -b;-c a]
    hCof = zeros(2,2,N/nTx)  ; 
    hCof(1,1,:) = sum(h(:,2,:).*conj(h(:,2,:)),1) + 10^(-Eb_N0_dB(ii)/10);  % d term
    hCof(2,2,:) = sum(h(:,1,:).*conj(h(:,1,:)),1) + 10^(-Eb_N0_dB(ii)/10);  % a term
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
    
    figure
    Ahat=real(yHat(1:2:end));
    Bhat=real(yHat(2:2:end));
    plot(t,Ahat,t, Bhat)
   
  