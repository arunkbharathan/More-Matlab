% % % % % % % % % % % % % % % %Code for Simulation Of OKUMURA Model
clc;
clear all;
close all;

Hte=30:1:100;    % Base Station Antenna Height 
Hre=input('Enter the receiver antenna height 3m<hre<10m : ');          % Mobile Antenna Height
d =input('Enter distance from base station 1Km<d<100Km : ');         % Distance 30 Km
f=input('Enter the frequency 150Mhz<f<1920Mhz : ');
c=3*10^8;
lamda=(c)/(f*10^6);
Lf = 10*log((lamda^2)/((4*pi)^2)*d^2); %   Free Space Propagation Loss
Amu = 35;       % Median Attenuation Relative to Free Space (900 MHz and 30 Km)
Garea = 9;      % Gain due to the Type of Environment (Suburban Area)
Ghte = 20*log(Hte/200); % Base Station Antenna Height Gain Factor
if(Hre>3)
Ghre = 20*log(Hre/3);
else
Ghre = 10*log(Hre/3);
end
%   Propagation Path Loss
L50 = Lf+Amu-Ghte-Ghre-Garea;
display('Propagation pathloss is : ');
disp(L50);

plot(Hte,L50,'LineWidth',1.5);
title('Okumura Model Analysis');
xlabel('Transmitter antenna Height (Km)');
ylabel('Propagation Path loss(dB) at 50 Km');
grid on;