function R = corrcubR(theta,D)
% return cubic correlation function
% theta = scale parameter, (d*1)
% D = distance matrix (k1*k2*d)
% R = cubic correlation function (k1*k2)

d = size(theta,1);
k1 = size(D,1);
k2 = size(D,2);
T = repmat(reshape(theta,[1 1 d]),[k1 k2]);
R = prod(((D<=(T./2)).*(1-6*(D./T).^2+6*(D./T).^3) ...
    +((T./2)<D & D<=T).*(2*(1-D./T).^3)),3);

