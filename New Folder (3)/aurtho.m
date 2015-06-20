function [Q,R] = aurtho(A,t)
[m,n] = size(A);
% compute QR using Gram-Schmidt
for j = 1:n
   v = A(:,j);
   for i=1:j-1
       q=cumsum(Q(:,i)'*A(:,j));
E=q(end)*t;
        R(i,j) = E;
        v = v - R(i,j)*Q(:,i);
   end
   q=cumsum(v.*v);
E=q(end)*t;
   R(j,j) = sqrt(E);
   Q(:,j) = v/R(j,j);
end