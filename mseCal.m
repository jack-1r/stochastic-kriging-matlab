function f = mseCal(X, fname)
% wrapper function for calculating the predicted MSE at the specified point
% using the model retrieved from the provided file
%   X: specified point to calculate the MSE
%   model: name of the file that store the model params

% TO-DO: implement params checking here

% load the model params from file
load(fname,'model');

f = mse(X, model);