%   Copyright 2010 The MathWorks, Inc.
function plot_trajectory(z,y)
%#codegen
eml.extrinsic('title','xlabel','ylabel','plot','axis','pause');
title('Trajectory of object [red] its Kalman estimate [blue]');
xlabel('horizontal position');
ylabel('vertical position');
plot(z(1), z(2), 'rx-');
plot(y(1), y(2), 'bo-');
axis([0, 12, -0.5, 2.5]);
pause(0.02);
end            % of the function