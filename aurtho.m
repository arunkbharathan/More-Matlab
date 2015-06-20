function [Q,R] = aurtho(A,t)
[m,n] = size(A);
% compute QR using Gram-Schmidt
for j = 1:n
   v = A(:,j);
   for i=1:j-1
       E=sum(Q(:,i)'*A(:,j))*t;
        R(i,j) = E;
        v = v - R(i,j)*Q(:,i);
   end
   E=sum(v.*v)*t;
   R(j,j) = sqrt(E);
   Q(:,j) = v/R(j,j);
end

