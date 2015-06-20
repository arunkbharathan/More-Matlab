%% Second Order Dynamic Systems and Damping
%
% MATLAB allows the visualization of equations, to aid better understanding
% of the physical meaning being expressed.  This example shows how various
% second order dynamic systems can be visualized, using the plot and
% annotation commands.
%
% Copyright 1984-2008 The MathWorks, Inc. 


%% Underdamped second order system
% The following equation describes an underdamped second order system:
%
% $$ x(t) = x_0 e^{-\zeta\omega_n t} \left({\zeta \over
% \sqrt{1-\zeta^2}}\sin\omega_dt + \cos\omega_dt \right) $$
%
% Given:
%
% $$ \begin{array}{l}
%    \zeta = 0.1 \\ \omega_n = 10 \\ \omega_d = \omega_n \sqrt{1-\zeta^2}
%    \\ x_0 = 10 \end{array} $$
% 
% Plot the displacement for, t = 0 to 5s

% Initialize Variables
z = 0.1;
wn = 10;
wd = wn * sqrt(1-z^2);
x0 = 10;
t = 0:0.01:5;

% Compute Equation for Displacement and Amplitude Decay Envelope
x = x0 * exp(-z*wn*t) .* (z/sqrt(1-z^2)*sin(wd*t) + cos(wd*t));
ampDecay = x0 * exp(-z*wn*t);

% Create Plots
figure
hold on
plot(t,x)
plot(t,ampDecay,'r:')
hold off
box on

% Label Figure
title('Underdamped Second Order System')
xlabel('Time [s]')
ylabel('Amplitude [cm]')
legend('System Response','Amplitude Decay','Location','SouthEast')


%% Comparing effects of different damping coefficients
% The damping coefficient of a system determines if the system is under
% damped, critically damped, or over damped. The systems, with damping
% coefficients 0, 0.99, and 3 are plot to compare their displacements.

% Initialize Variables
x0 = 10;
z = [0.1;0.99;3];
wn = 10;
wd = wn * sqrt(1-z.^2);
t = 0:0.01:5;
A = z./sqrt(1-z.^2);

% Compute Displacements for Each Damping Coefficient
for k = 1:length(z)
	x(k,:) = x0 * exp(-z(k)*wn*t) .* (A(k)*sin(wd(k)*t) + cos(wd(k)*t));
end

% Create Plot
figure
plot(t,x)

% Label Figure
title('Comparing Second Order Systems with Various Damping Coefficients')
xlabel('Time [s]')
ylabel('Amplitude [cm]')
legend('zeta = 0.1','zeta = 0.99','zeta = 3','Location','SouthEast')

