function [data] = Load_data(name)
% Training mode - Load all the wave files to database (codebooks) %
data = cell(size(name,1),1);
for i=1:size(name,1)
temp = [name(i,:) '.wav'];
tempwav = wavread(temp);
data{i} = tempwav;
end