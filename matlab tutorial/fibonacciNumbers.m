%% Using a WHILE loop
%   Generate the Fobonacci sequence until the ratio of the last two numbers
%   converge converge on the golden ratio

phi = (1+sqrt(5))/2;  %Define the golden ratio
fib = [1 1];	%Initialize the series
tol = eps;		%Specify the tolerance as the floating-point relative 
				%accuracy at 1.
				
% Error calculation:
% Difference between the golden ratio, and the ratio of
% the last two numbers of the series being computed
err = phi - fib(end)/fib(end-1);  

while abs(err) > tol  %Error is greater than tolerance
	fib(end+1) = fib(end) + fib(end-1);  %Calculate the next number
	err = phi - fib(end)/fib(end-1); %Error calcuation
end

figure
plot(fib,'.')
title('Plot of Fibonacci Numbers:')
xlabel('Number of Terms')
ylabel('Value')
text(3,6e7,...
	{'The Ratio of the Last Two Terms';'Converges on the Golden Ratio'},...
	'EdgeColor','k')

numberOfTerms = length(fib)

%% Using a FOR loop
%   Generate a specified number of numbers for the Fobonacci sequence

n = 10;  %specify how many numbers to generate
fibn = ones(1,n);  %Preallocate memory for the variable

for k = 3:n
    fibn(k) = fibn(k-1) + fibn(k-2);
end

figure
plot(fibn,'.')
title('Plot of Fibonacci Numbers')
xlabel('Number of Terms')
ylabel('Value')