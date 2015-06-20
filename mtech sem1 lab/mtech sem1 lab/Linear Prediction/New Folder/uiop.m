function Wk1=uiop(x)
corres = x(1:160)*(x(1:160))'/10;
    R=toeplitz(corres(1:10));%constructing R(NxN) from corres(1xN)
    r=-corres(2:11)';
    Wk1=(inv(R)*r)'%Wk1 is a(=Rinverse*-r);
end
