%% Global Warming Analysis
% This is an analysis of global temperature anomaly data collected from
% 1850 to 2007.
%
% Data Source:
% HadCRUT3 is a record of surface temperatures collected from land and
% ocean based stations as compiled by the Climatic Research Unit of the
% University of East Anglia and the Hadley Centre of the UK Meteorological
% Office. 
% 
% Following the common practice of the IPCC, the zero is the mean
% temperature from 1961-1990.
%
% http://www.cru.uea.ac.uk/cru/data/temperature
%
% Copyright 1984-2008 The MathWorks, Inc. 

%% Load Data into MATLAB

% Load the MAT-file containing previously saved variables
load annual_temps.mat


%% Visualize Raw Data

% Create a plot of all temperature anomaly measurements against the year
figure
plot(year,annual)
title('HadCRUT3 Temperature Anomaly Measurements')
xlabel('Year')
ylabel('Temperature Anomaly (ºC)')


%% Calculate and Visualize Annual Average Temperature Anomaly

% Calculate the average annual measurement using MEAN
annual_avg = mean(annual);

% Create an area plot for the annual average
figure
area(year,annual_avg)
title('Average Annual Temperature Anomaly')
xlabel('Year')
ylabel('Temperature Anomaly (ºC)')


%% Visualize Positive vs. Negative Temperature Anomaly

% Divide the data into positive and negative values: 
above_zero = annual_avg .* (annual_avg >= 0);	% Values Above Zero
below_zero = annual_avg .* (annual_avg <  0);	% Values below Zero

% Create a plot 
figure
hold on  % Hold figure to allow multiple graphing commands to add to the existing graph
plot(year,annual_avg,'--k','LineWidth',0.5);
bar(year,above_zero,'FaceColor','r','EdgeColor','none')
bar(year,below_zero,'FaceColor','b','EdgeColor','none')
hold off  % Turn hold off

% Annotate figure
title('Positive vs Negative Temperature Annomaly')
xlabel('Year')
ylabel('Temperature Anomaly (ºC)')
legend('Annual Average','Above Average','Below Average','Location','SE')
text(1850,0.5,'\bfNorthern Hemisphere')


%% Calculate and Visualize Five Year Moving Average Temperatures

% Apply a moving average smoother to the data using CONVN
span = 5; % Size of the averaging window (5 years)
window = ones(1,span)/span; 
five_year_avg = convn(annual_avg,window,'valid');
yr = year(ceil(span/2):length(five_year_avg)+ceil(span/2)-1);

% Create plots to compare annual temperatures and smoothened temperatures
figure 
hold on
plot(year,annual_avg,'--ko',...
	'LineWidth',1,...
	'MarkerEdgeColor','k',...
	'MarkerFaceColor','b',...
	'MarkerSize',3)
plot(yr,five_year_avg,'r-','LineWidth',3)
hold off

% Annotate figure
title('Comparing the Annual Temperature Anomaly and the Five Year Moving Average')
xlabel('Year')
ylabel('Temperature Anomaly (ºC)')
legend('Annual Average','Five Year Average','Location','SE')

