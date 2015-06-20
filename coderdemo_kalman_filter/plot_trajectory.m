%   Copyright 2010 The MathWorks, Inc.
function plot_trajectory(z,y)
%#codegen
eml.extrinsic('title','xlabel','ylabel','plot','axis','pause');
title('Trajectory of object [red] its Kalman estimate [blue]');
xlabel('horizontal position');
ylabel('vertical position');
plot(z(1), z(2), 'rx-');
plot(y(1), y(2), 'bo-');
axis([-1.1, 3, -1.1, 1.1]);
pause(0.02);
end            % of the function