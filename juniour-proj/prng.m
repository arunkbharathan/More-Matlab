function[states code]=prng(seed,polynomial)
%seed=initial state of LFSR of length 5
%polynomial=tap positions, e.g.[5 2]
% state will be matrix containing the states of LFSR row wise
% code= generated code
%seed of length 3 and two taps-polynomial
N=5;
states=zeros(2^(N-1),N);
states(1,:)=seed;
for k=1:2^N-2;
b=xor(seed(polynomial(1)), seed(polynomial(2)));
j=1:N-1;
seed(N+1-j)=seed(N-j);
seed(1)=b;
states(k+1,:)=seed;
end
code=states(:,N)';
end