clc
clear all
close all;
tic;
%% TRANSMITTER
% initialize
    M                   = 4;                    %   QPSK signal constellation
    data_length         = 1024*10;              %   data points
    block_size          = 64;                   %   size of each ofdm block
    cp_len              = ceil(0.1*block_size); %   length of cyclic prefix
    no_of_ifft_points   = block_size;           %   8 points for the FFT/IFFT
    snr_db              = linspace(0,20,10);
    snr=10.^(snr_db/10);
    
    [Sym]=dmpsksym(M);
    
% Data Genration
    data_tx=round(rand(1,data_length));
    figure();
    plot(data_tx(1:40),'ro');hold on;
    stairs(data_tx(1:40),'k');ylim([-.5 1.5]);
    title('Data Genration');xlabel('Time');ylabel('amplitude');
    
% Serial To Parallel Conversion
    data_par=reshape(data_tx,block_size,[]);

% Digital Modulation
    [qpsk_symbols,data]=dmpsk(data_par,M);
    scatterplot(qpsk_symbols(:,1));
    title('Constellation size at transmitter side');
    
% IFFT Transformation
    [r c]=size(qpsk_symbols);
    ifft_symbols=zeros(r,c);
for ii=1:c
    ifft_symbols(:,ii)=ifft(qpsk_symbols(:,ii));
end

% Adding Cycle Prefix
    [r c]=size(ifft_symbols);
for tt=1:cp_len
    cp_symbols=zeros(1,r);
    cp_symbols=ifft_symbols((r),:);
    ifft_symbols=[cp_symbols;ifft_symbols];
end
    ofdm_symbols=ifft_symbols;
    
% Plotting the OFDM symbols
    ofdm_symbols_tx=reshape(ofdm_symbols,1,[]);
    l=cp_len+r;         % length of OFDM symbols
    figure();    
    i=1;
    subplot(4,1,i);plot(real(ofdm_symbols_tx(i:l)),'-ko');i=i+1;
    title('OFDM symbols / \musec');grid on;
    subplot(4,1,i);plot((l+1:i*l),real(ofdm_symbols_tx(l+1:i*l)),'-ko');i=i+1;grid on;
    subplot(4,1,i);plot((i-1)*l+1:i*l,real(ofdm_symbols_tx((i-1)*l+1:i*l)),'-ko');i=i+1;grid on;
    subplot(4,1,i);plot((i-1)*l+1:i*l,real(ofdm_symbols_tx((i-1)*l+1:i*l)),'-ko');grid on;
    xlabel('Showing only first 4 OFDM symbols')
    
% STBC mapper
% Input
    [r c]=size(ofdm_symbols);X1=[];X2=[];
for re=1:c
    temp(1,:)=ofdm_symbols(:,re).';
    if rem(re,2)==0
        x1(1,:)=temp;
        X1=[X1 x1];
    else
        x2(1,:)=temp;
        X2=[X2 x2];
    end
end
X=[X1;X2];


for snri=1:length(snr)    
for itr=1:100 
%% STBC mapper and transmission
% Initialize
    ntx=2;
    nrx=2;
% channel creation(1/sqrt(2))
    [R C]=size(X);
    n=C;
    H_up = (raylrnd((1/sqrt(2)),ntx,nrx,n) + 1j*raylrnd((1/sqrt(2)),ntx,nrx,n))*1; % Rayleigh channel
    H_down1= conj(H_up(:,2,:));     %
    H_down2= -conj(H_up(:,1,:));    % changing the channel as orthogonal
    H_down=[H_down1 H_down2];       %
    H=[H_up;H_down];
    
    N = ((randn(nrx,n) + 1j*randn(nrx,n)))*(1/snr(snri)); % white gaussian noise, 0dB variance
    N1=N(1,:);
    N2=N(2,:);
    N1_=conj(N(1,:));
    N2_=conj(N(2,:));
    N=[N1;N2;N1_;N2_];
%     scatterplot(N(1,:))

%% RECEIVER
% receiver Y=XH+N
    for t=1:n
        Y(:,1,t)=H(:,:,t)*X(:,t)+N(:,t);
    end

% ML detector
    for i=1:n
        HH(:,:,i)=H(:,:,i)';                % hermitian transpose
        HHH(:,:,i)=HH(:,:,i)*H(:,:,i);
    end
    HHH;
    HH;
% Estimation of symbols
    for i=1:n
        x(:,i)=(HH(:,:,i)*Y(:,:,i));
    end
    
    for i=1:n
        r_cap(1,i)=x(1,i)/HHH(1,1,i);
        r_cap(2,i)=x(2,i)/HHH(2,2,i);
    end
    
% parallel conversion from STBC symbols  
    seg=block_size+cp_len;temp=[];
    for i=1:n/seg
        temp1=r_cap(1,((seg*(i-1)+1):i*seg));
        temp2=r_cap(2,((seg*(i-1)+1):i*seg));
        temp=[temp temp2.' temp1.'];
    end
    ofdm_detected_par=temp;
    
% Remove the cyclic prefix
    ofdm_par_cp=ofdm_detected_par([(cp_len+1):(cp_len+block_size)],:);
    
% FFT Transformation
    [r c]=size(ofdm_par_cp);
    fft_symbols=zeros(r,c);
for iii=1:c
    fft_symbols(:,iii)=fft(ofdm_par_cp(:,iii));
end
    line=fft_symbols;
    
% QPSK Demodulation
    [data,line]=dmpskdem(line,M);

% Parallel to Serial conversion
    bits_received=reshape(data,1,[]);% No.of parallel lines are 4 %
    
% BER analysis
    Ber(itr)=(data_length-sum(data_tx==bits_received))/data_length;
end
    BER(snri)=sum(Ber)/100;
end
    BER;
    scatterplot(line);
    title('Constellation size at receiver side')

    figure();
    semilogy(snr_db,BER,'-kd','linewidth',2,'markerfacecolor','r');
    title('Bit Error Rate for FFT-OFDM-MIMO');grid on;
    xlabel('SNR dB');ylabel('Error Rate')
%% ENDDD
toc;