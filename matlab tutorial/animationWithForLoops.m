%% Using a FOR loop to create animations
% A FOR loop can be useful in creating animations in MATLAB.
% It allows you to fresh the image or plot pausing in between each frame or
% point.
%
% In the first example, we are displaying an image representing the topology of
% Cape Cod, Massachusetts in the US.  The data being displayed represents
% elevation.  By gradually reducing the elevation and updating the display,
% we can visibly see the effect of a receding shore line if the sea level
% started rising.
%
% In the second example, we use a FOR loop to animate a sine wave instead
% of plotting it all at once.

%% Load data and Initialize an Image
load cape
image(X)
colormap(map) %Specify the indexed colormap for the data

%% Run FOR loop to display animation of a receding coastline
for i = 1:max(X(:))
	image(X-i)	%Refresh image with receding coastline
	pause(0.2)	%Pause for 0.2s
	
	threshold = 0.9;  %Initialize threshold for breaking out of the FOR loop
	idx = find(X-i <= 0);  %Find the index of elements that are below sea level
	
	if numel(idx)/numel(X) >= threshold
	% If the percentage of elements below sea level (area underwater) is
	% greater than the threshold, break out of the FOR loop and stop the
	% animation.
		break
	end	
end

%% Run FOR loop to animate a sine wave plot

% Initialize data
x = 0:0.1:2*pi;
y = sin(x);

% Create and prepare figure
figure
axis([0 2*pi -1 1])
title('Animation of a Sine Wave')
xlabel('x')
ylabel('y = sin(x)')
hold on

for n = 1:length(x)
	plot(x(n),y(n),'.')
	pause(0.1)
end
hold off