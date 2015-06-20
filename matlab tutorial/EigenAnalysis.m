%% Computing Eigenvalues and Eigenvectors of a Matrix
% 
% Eigenvalue decomposition can be carried out to determine the eigenvalues
% and eigenvectors of a matrix.
% 
% Given a matrix:
%
% $$ A = \left[ \begin{array}{cc}
%              a_{11} & a_{12} \\ a_{21} & a_{22}
%           \end{array} \right], $$
%
% that defines a system of differential equations
%
% $$ \dot{\mathbf{x}} = A\, \mathbf{x}, $$
%
% and, if
%
% $$ \mathbf{x} = \left[ \begin{array}{c} u \\ v \end{array} \right], $$
%
% then
%
% $$ \begin{array}{l} \dot{u} = a_{11}\, u + a_{12}\, v \\ \dot{v} =
% a_{21}\, u + a_{22}\, v, \end{array} $$
% 
% can be used to visualize the vector field of the system.  Plotting
% the eigenspaces spanned by the eigenvectors, illustrates the invariance
% of the eigenspaces for this system.


%% Calculate Eigenvalues and Eigenvectors
% 
% The eigenvalues of a matrix can be computed by determining the roots of
% the characteristic polynomial.
% 
% Alternately, the function EIG can be used
% to compute the eigenvalues.  The EIG function also computes the
% eigenvectors directly.

clc

% Define the matrix 'A'
A = [2 -1;1 -3] 
% A = eye(2)

% Calculate coefficients of characteristic polynomial
p = poly(A)

% Calculate roots of the characteritic polynomial (i.e. the eigenvalues)
r = roots(p)

% Calculate the eigenvectors and eigenvalues of 'A' directly using EIG
[eVec eVal] = eig(A)


%% Visualize the System Vector Field and its Eigenspaces

% Create meshgrid for visualizing the system
X = -3:0.4:3;
Y = X;
[XX, YY] = meshgrid(X,Y);

% Determine the components of the vector field of the system
u_dot = A(1,1)*XX + A(1,2)*YY;
v_dot = A(2,1)*XX + A(2,2)*YY;

% Create figure
figure
axis equal
axis([-3 3 -3 3])
hold on

% Visualize the vector field using a quiver plot
quiver(XX,YY, u_dot, v_dot, 'k')

% Plot the eigenspaces spanned by the eigenvectors
h1 = plot([-3 3], [-3 3]*eVec(2,1)/eVec(1,1), 'r');
h2 = plot([-3 3], [-3 3]*eVec(2,2)/eVec(1,2), 'r');

% Plot the other streamlines of the vector field
x_start = [-2:2 -2:2];
y_start = [-3*ones(5,1) 3*ones(5,1)];
h3 = streamline(XX, YY, u_dot, v_dot, x_start, y_start);

% Annotate the figure
title('Vector Field of the System: $\dot{\mathbf{x}}=A\,\mathbf{x}$',...
	'Interpreter', 'latex')
xlabel('u')
ylabel('v')
legend([h2 h3(1)],'Eigenspaces','Streamlines',...
	   'Location','SE');
