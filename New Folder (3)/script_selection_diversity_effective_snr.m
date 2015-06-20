%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All rights reserved by Krishna Pillai, http://www.dsplog.com
% The file may not be re-distributed without explicit authorization
% from Krishna Pillai.
% Checked for proper operation with Octave Version 3.0.0
% Author        : Krishna Pillai
% Email         : krishna@dsplog.com
% Version       : 1.0
% Date          : 6th September 2008
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script for computing the SNR improvement in 
% Rayleigh fading channel with selection diversity

clear
N = 10^4; % number of bits or symbols

% Transmitter
ip = rand(1,N)>0.5; % generating 0,1 with equal probability
s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0

nRx = [1:20];
Eb_N0_dB =   [25]; % multiple Eb/N0 values

for jj = 1:length(nRx)

    for ii = 1:length(Eb_N0_dB)

        n = 1/sqrt(2)*[randn(nRx(jj),N) + j*randn(nRx(jj),N)]; % white gaussian noise, 0dB variance
        h = 1/sqrt(2)*[randn(nRx(jj),N) + j*randn(nRx(jj),N)]; % Rayleigh channel

        % Channel and noise Noise addition
        sD = kron(ones(nRx(jj),1),s);
        y = h.*sD + 10^(-Eb_N0_dB(ii)/20)*n;


        % finding the power of the channel on all rx chain
        hPower = h.*conj(h);
        
        % finding the maximum power
        [hMaxVal ind] = max(hPower,[],1);
        hMaxValMat = kron(ones(nRx(jj),1),hMaxVal);
        
        % selecting the chain with the maximum power
        ySel = y(hPower==hMaxValMat);
        hSel = h(hPower==hMaxValMat);
        
        % effective SNR
        EbN0EffSim(ii,jj) = mean(hSel.*conj(hSel));
        EbN0EffThoery(ii,jj) = sum(1./[1:nRx(jj)]);

    end

end


% plot
close all
figure

plot(nRx,10*log10(EbN0EffSim),'bp-','LineWidth',2);
hold on
plot(nRx,10*log10(EbN0EffThoery),'gd-','LineWidth',2);
axis([1 20 0 6])
grid on
legend('theory', 'sim');
xlabel('Number of receive antenna');
ylabel('effective SNR, dB');
title('SNR improvement with Selection Combining');









