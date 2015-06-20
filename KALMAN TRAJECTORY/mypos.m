close all;
global x_est p_est gkg              % Initial state conditions
x_est=[0;0;0;0;0];p_est=zeros(5,5);gkg=0;
x=load('matlabtrajec1.mat');y=x.ya;x=x.xa;
fgh=[x;y];
ObjTrack(fgh)
sound(1)

% Enabling Ax is giving better tracking