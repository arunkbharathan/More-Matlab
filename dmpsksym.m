%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% This file locally genrate the mpsk symbols
%%%%  for the ML detector 

function [Sym]=dmpsksym(con_size)
    amp=2;
    phase=linspace(0,2*pi,con_size+1);  %
    phase=phase(1:con_size);            % 
    r=amp;                              % Genreation of symbols
    Sym=r.*(cos(phase)+1j*sin(phase));  %
    
return