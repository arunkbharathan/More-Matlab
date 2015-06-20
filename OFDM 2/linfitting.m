% Simulate position vs. time data for a rolling ball
close all; clear all;
randn('state',0); % Reset the random number generator
x = 1:9;  % define the intervals for taking measurments
vox = 0.5;    % initial velocity in the x direction
t = x/vox;    % compute t for ideal case
t = t+.5*randn([size(x) 1]); % add some noise
plot(x,t,'o') % plot the data and add labels
ylabel('time (sec)')
xlabel('position (m)')
title('Time vs. position for a rolling ball')
axis([0 9 0 20])
hold on  % keep the first graph up while we plot the fitted line

% Fit a line thru the data and plot the result over the data plot
temp = polyfit(x,t,1); % least squares fitting to a line
a1 = temp(2) % y-intercept of the fitted line
a2 = temp(1) % slope of fitted lines
fit = a1+a2*x;
plot(x,fit,'r')
axis([0 9 0 20])
hold on

R=corrcoef(x,t);R(1,2)
%A correlation coefficient with a magnitude near 1 (as in this case) represents a good fit.  As the fit gets worse, the correlation coefficient approaches zero.

% Try a higher order fit
a = polyfit(x,t,8);
new_x = 0:.1:10;
new_t = polyval(a,new_x);
plot(new_x,new_t)
axis([0 9 0 20])