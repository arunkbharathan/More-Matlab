% convert to indexed image
[IND,map] = rgb2ind(A,32);
% save indexed png
imwrite(IND, map, 'test.png', 'bitdepth', 4);