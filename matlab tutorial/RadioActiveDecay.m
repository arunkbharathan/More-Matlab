%% Analysis of Radioactive Decay Measurements
% Meyer and von Schweidler, 1905
%
% Raw radioactive data measurements are plot and a curve is fit to the
% natural log of the activity.  The coefficients of the curve are
% extracted and used to calculate the half life of the radioactive decay.
% 
% The following equation describes radioactive decay over time:
% 
% $$ {\bf y} = {\bf y_0}{2}^{-t/T} $$
%
% Therefore it can be reduced to a linear equation by taking its log
% 
% $$ \log{\bf y} = \log{\bf y_0} - \frac{t}{T}{\log 2} $$
% 
% The initial value and Half-life, can be determined from a linear
% curve fitted to a semi-log plot of the activity.
% 
% Initial Activity:
% 
% $$ {\bf y_0} = e^{y-intercept} $$
%
% Half-life:
% 
% $$ {\bf T} = -\frac{\log 2}{slope} $$
%
% Copyright 1984-2008 The MathWorks, Inc. 


%% Input and Organize Data
data = [0.2 	35.0
2.2 	25.0
4.0 	22.1
5.0 	17.9
6.0 	16.8
8.0 	13.7
11.0 	12.4
12.0 	10.3
15.0 	7.5
18.0 	4.9
26.0 	4.0
33.0 	2.4
39.0 	1.4
45.0 	1.1];

time = data(:,1);	%Time in days
rActivity = data(:,2);	%Relative Activity


%% Visualizing Raw Data
figure
plot(time,rActivity,'.')
title('Radioactive Decay Measurement')
xlabel('Time [days]')
ylabel('Relative Activity')


%% Fit Linear Curve to log of Data

% Carry out linear curve fit to obtain coefficients
p = polyfit(time,log(rActivity),1); 

% Obtain a curve for the coefficients obtained
y = polyval(p,time);  

% Plot results of curve fit against log of data
figure
plot(time,log(rActivity),'r.',time,y,'-')
title('Log of Radioactive Decay Measurement')
xlabel('Time [days]')
ylabel('Relative Activity')
legend('Log of Activity','Fitted Curve','Location','SouthWest')


%% Calculate Half Life
y0 = exp(p(2));
T = -log(2)/p(1);
disp(['The Half-life is estimated to be ' num2str(T) ' days'])


%% Final Curve that Models the Radioactive Decay
fit = y0 * 2.^(-time/T);

figure
plot(time,rActivity,'.',...
	 time,fit,'-')
title('Fitted Curve to Radioactive Decay Measurement')
xlabel('Time [days]')
ylabel('Relative Activity')
legend('Raw Measurements','Fitted Curve')
