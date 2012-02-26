function [Y Vhat] = procBranin(X, n, stochastic)
% simulating a stochastic process generate by the Branin fucntion and a
% Gaussian noise process 
%   X: input values
%   n: number of replication to run for each design point.
RandStream.setDefaultStream ...
     (RandStream('mt19937ar','seed',sum(100*clock)));

if (size(X, 2) ~= 2)
    error('input value must be 2-dimensional vector')
end

k = size(X, 1);

Y = zeros(1, k);
Vhat = zeros(1, k);
for i = 1:k
    temp = zeros(1, n(i));
    for j = 1:n(i)
        switch stochastic
            case 'norm'
                temp(j) = fBranin(X(i,1), X(i,2)) + normrnd(0,1);
            case 'none'
                temp(j) = fBranin(X(i,1), X(i,2));
        end
    end
    Y(i) = mean(temp);
    Vhat(i) = var(temp,1)/n(i);
end
Y = Y';
Vhat = Vhat';

