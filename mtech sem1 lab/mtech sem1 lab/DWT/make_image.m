function [imx] = make_image(x)
min_x = min(min(x));
max_x = max(max(x));
scale = max_x-min_x;
imx = uint8(floor(x-min_x)*255/scale);