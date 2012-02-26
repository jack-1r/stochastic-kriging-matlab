function R = correxpR(theta,D)
% return gauss or exponential correlation function
d = size(theta,1);
k1 = size(D,1);
k2 = size(D,2);
R = exp(sum(D.*repmat(reshape(theta,[1 1 d]),[k1 k2]),3));
