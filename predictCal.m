function [f mse] = predictCal(XK, fname)
% wrapper for the SKpredict function to calculate the SK predicted response
% at specified point using the specified model retrieved from file.

% TO-DO: implement params validation here

% load the model params from file
load(fname,'model');

K = size(XK, 1);
BK = repmat(1, [K 1]);
[f mse] = SKpredict(model,XK,BK);
