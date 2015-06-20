function [cepstral] = mfcc(x,y,fs)
% Calculate mfcc's with a frequency(fs) and store in ceptral cell. Display
% y at a time when x is calculated
cepstral = cell(size(x,1),1);
for i = 1:size(x,1)
disp(y(i,:))
cepstral{i} = melcepst(x{i},fs,'x');
end