function [isTri,typeTri,areaTri] = isTriangle(L1, L2, L3)
%ISTRIANGLE   determines if the three lengths provided can form a triangle.
%   isTri = isTriangle(L1,L2,L3) returns 1 if the three lengths can form a
%   triangle and 0 otherwise.
%
%   [isTri,typeTri,areaTri] = isTriangle(L1,L2,L3) also returns the type of
%   triangle: (Regular, Equilateral, or Isosceles), as well as the area
%   enclosed.
%
%   Example:
%   [isTri,typeTri,areaTri] = isTriangle(2,3,2)
%
%   isTri =
%        1
%   typeTri =
%   Isosceles
%   areaTri =
%       1.9843

%   Copyright 2008 The MathWorks, Inc. 


% Initialize outputs
isTri = false;
typeTri = '';
areaTri = NaN;

% Create a sorted array of the inputs lengths
s = sort([L1 L2 L3]);


if (s(1)+s(2)) > s(3)
% If the sum of the two shortest sides is greater than the longest side,
% the lengths can form a triangle.

	isTri = true;
	typeTri = 'Scalene';
	
	if s(1) == s(3)
	% If the shortest and longest lengths are equal, it implies that all
	% three lengths are equal, and that the three sides form a equilateral
	% triangle.
	
		typeTri = 'Equilateral';
		
	elseif s(1)==s(2) || s(2)==s(3)
	% If middle length is equal to either the longest or shortest length,
	% the lengths form an isosceles triangle.
	
        typeTri = 'Isosceles';
	end
	
	% Calculate the area of the triangle using Heron's Formula
	p = sum(s)/2;
	areaTri = sqrt(p*(p-s(1))*(p-s(2))*(p-s(3)));
	
end
