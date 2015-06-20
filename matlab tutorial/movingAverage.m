function [avg,tout] = movingAverage(data,time,span)
%MOVINGAVERAGE
% Apply a moving average smoother to the data using CONVN.  Here we use
% CONVN to calculate only the valid points.
%
% [avg,tout] = movingAverage(data,time,span) takes in the data, associated
% time, and the period for the moving average.  It returns the smoothed
% data amd the associated time vector.

%   Copyright 2008 The MathWorks, Inc. 


% Create the moving average window from the span
window = ones(1,span)/span;

% Use CONVN to compute the moving average
avg = convn(data,window,'valid');

% Update the time vector to match the average computed
tout = time(ceil(span/2):length(avg)+ceil(span/2)-1);