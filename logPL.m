function f = logPL(parms,k,d,Dist,B,V,Y,gammaP)

% negative of log profile likelihood  
% This is a function of theta and tau2.
% we have profiled out over beta
% parms = [tausq;theta] 
% k = number of design points
% d = dimension of space
% Dist = matrix of distances between design points
% B = basis functions
% V = intrinsic covariance matrix
% Y = simulation output

if ((length(parms)~=d+1))
    error('Parameter vector must be length d+1');
end
if not(all(size(Y)==[k 1]))
    error('Output vector must be k by 1.')
end
if (size(B,1)~=k)
    error('Basis function matrix must have k rows.')
end
if not(all(B(:,1)==1))
    error('The first column of the basis function matrix must be ones.')
end
if (not(all(size(V)==[k k])))
    error('The intrinsic covariance matrix must be k by k.')
end

if(parms(1)<=0 || min(parms(2:d+1)) <= 0.001)
    f = inf;
    return;
end

tausq = parms(1);
theta = parms(2:d+1);

% get correlation matrix given theta
if gammaP == 3
    R = corrcubR(theta,Dist);
else
    R = correxpR(theta,Dist);
end
    
% sum of extrinsic and intrinsic covariances
Sigma  = tausq*R + V;
[U,pd] = chol(Sigma);

if(pd>0)
    save data;
    error('covariance matrix is nearly singular');
end

% invert it via Cholesky factorization
L = U';
Linv = inv(L);
Sinv = Linv'*Linv;

% the optimal beta given theta and tau2
beta = inv(B'*Sinv*B)*(B'*(Sinv*Y)); 
Z = L\(Y-B*beta);

% negative log likelihood
f = (log(det(L)) + 0.5*Z'*Z + 0.5*k*log(2*pi));

