
%===============================================================
function [a_p var_p]  = Levinson_Durbin(x,p)

N = length(x);
for ii=1:N
    Rxx(ii) = x(1:N-ii+1)*(x(ii:N))'/N;
end


a(1) = 1
a(2) = -Rxx(2)/Rxx(1)

for jj=1:p-1
    var(jj+1) = Rxx(0+1)+a(1+1:jj+1)*Rxx(1+1:jj+1)';
    D(jj+1) = a(0+1:jj+1)*(fliplr(Rxx(2:jj+1+1)))';
    gama(jj+1+1) = D(jj+1)/var(jj+1);
    var(jj+1+1) = (1-(gama(jj+1+1))^2)*var(jj+1);
    a_temp(1) = 1;
    for kk=1:jj
        a_temp(kk+1) = a(kk+1)-gama(jj+1+1)*a(jj+1-kk+1);
    end
    a_temp(jj+1+1) = -gama(jj+1+1);
    a = a_temp;
    a
end
a_p = a;
var_p = var(p+1);


