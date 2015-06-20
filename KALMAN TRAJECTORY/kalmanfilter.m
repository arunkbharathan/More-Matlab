%   Copyright 2010 The MathWorks, Inc.
function y = kalmanfilter(z) 
%#codegen

dt=1;global x_est p_est gkg
% Initialize state transition matrix
A=[ 1 0 dt 0 0;...     % [x  ]            
       0 1 0 dt 0;...     % [y  ]
       0 0 1 0 0;...     % [Vx]
       0 0 0 1  dt;...     % [Vy]
%        0 0 0 0 1 0;...
       0 0 0 0 1 ];       % [Ay]
H = [ 1 0 0 0 0 ; 0 1 0 0 0 ];    % Initialize measurement matrix
Q = eye(5);
R = 1000 * eye(2);


% Predicted state and covariance
if (gkg==1)
    x_est = A * x_est;
    y = H * x_est;
return
end
x_prd = A * x_est;

p_prd = A * p_est * A' + Q;
% Estimation
S = H * p_prd' * H' + R;
B = H * p_prd';
klm_gain = (S \ B)';
% Estimated state and covariance
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;
if(norm(p_est)>534.38)
    gkg = 1;
end
% Compute the estimated measurements
y = H * x_est;
end                % of the function