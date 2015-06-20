%% Modeling Average Temperature as a Random Process for Forecasting
% Proposed model for next year's average temperature is the following:
% 
% $$ y_n = y_{n-1} + K + (zero\ mean\ normally\ distributed\ noise) $$
%
% This is an auto-regressive model.
%
% We first test the reasonableness of the proposed model using hypothesis
% testing.  If the model appears to reasonably fit the data, we proceed by
% estimating the K coefficient (upward drift in temperature) and the
% standard deviation of the noise (uncertainty in temperature movement).

%% Load global data and compute average change in temperature year on year.
% We average the 12 monthly values to estimate the global average
% temperature anomaly, then find the year on year difference in global
% average temperature.
load annual_temps.mat
annual_avg = mean(annual);

yoychange = diff(annual_avg);


%% Test plausibility of the proposed model.
% We want to see if the yearly changes in average temperature are close to
% normally distributed.  We use two hypothesis testing procedures for this.

% Graphical view of correlation in year over year changes:
% Are big increases in temperature followed by other big increases, or are
% temperature changes in successive years uncorrelated?
[s,lags] = xcorr(yoychange,yoychange); %This function requires the Signal Processing Toolbox

figure
plot(lags,s)
title('Auto-correlation of YOY change')
xlabel('Difference in years')
ylabel('Correlation')

% The Runs test is an analytical check of the same question posed above: Do
% extreme yearly changes clump together?  If either positive or negative
% correlations are found, the "p" output will be low.  If the yearly changes
% are largely uncorrelated, "p" will be higher.  The arbitrary threshold of
% 0.05 is commonly chosen in scientific hypothesis testing.
significancelevel = 0.05;
[h,p] = runstest(yoychange,significancelevel); %This function requires the Statistics Toolbox

if p > significancelevel
    disp('Runs Test finds no evidence of trend: Model is OK');
else
    disp('Runs Test finds evidence of trend: Model may not be comprehensive enough');
end

% Test for normality of the data set.  Result indicates the dataset is
% consistent with assumption of normal distribution.
[h,p] = lillietest(yoychange); %This function requires the Statistics Toolbox

figure
histfit(yoychange,15) %This function requires the Statistics Toolbox
title('Distribution of changes in avg. temp.')

% Result of RUNSTEST and test of normality indicates it can make sense to
% think of each observation as an independent draw from normal
% distribution.  Here we compute the mean and standard deviation of this
% normal distribution.
avg_increase = mean(yoychange);
warming_std= std(yoychange);


%% Forecast 100 possible temperature paths for the next 10 years, assuming the current trend continues
yoychanges = avg_increase + warming_std*randn(10,100);

simfuturetemps = annual_avg(end) + [zeros(1,100); cumsum(yoychanges)];

figure
plot((0:10)',simfuturetemps)
title('100 possible paths of global avg. temperature for the next 10 years')
xlabel('Time (years)')
ylabel('Global Avg. Temp.')

% Given the model, how likely is it that the temperature will be higher 10
% years from now than it is this year?
tenyearchange = sum(yoychanges);

figure
hist(tenyearchange)
title('Distribution of simulated 10-year changes in global avg. temp.')
xlabel('10-year change in global avg. temp.')
ylabel('Number of occurrences in 100 trials')

% In how many scenarios did the average temperature rise over 10 years?
pctofincrease = sum(tenyearchange > 0)/100;
disp(sprintf('Estimated probability of temperature increase over 10 years: %f',pctofincrease));
