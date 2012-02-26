function f = modelFitting(X, Y, Vhat, algor_sel)
% wrapper function for SKfit that store the model params into a temp .MAT
% file for later retrieval

k = size(X, 1);
B = repmat(1, [k 1]);   % default for this version. to be extended in the future
gammaP = 2;             % use Gaussian correlation model by default

model = SKfit(X, Y, B, Vhat, gammaP, algor_sel);

% output all information to the temp file.
fname = tempname          % get a temp filename
save(fname, 'model');

f = strcat(fname,'.mat');
return