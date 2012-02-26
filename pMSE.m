% Script file: 
%   pMSE.m

% Purpose: This function return the coordinates of the local minimum points on
%   a partition of the response surface

% Record of revisions
%   Date        Programmer      Description of change
%   ========    ==========      =========================================
%   11/09/21    hieutd          Original code.

% Define variables:
%   SKmodel: text string - name of the file containing the SK model params
%   SASetting: text string - name of the file containing the SA setting

function [min fval] = pMSE(SKmodel, ub, lb, SASetting)

% import all the setting from the config file
A = importdata(SASetting);
functol = A(2,1);
paramtol = A(3,1);
maxEval = A(4,1);
neps = A(5,1);
nt = A(1,1);

[k d] = size(lb);
if (d == 1)
    lb = reshape(lb, d, k);
    ub = reshape(ub, d, k);
end

% [k d] = size(ub);

% calculate the optimum point using SA
init = lb + (ub-lb)./2;
loss = @(x) mseCal(x, SKmodel);

controls.ub = ub;
controls.lb = lb;
controls.nt = nt;
controls.functol = functol;
controls.paramtol = paramtol;
controls.maxEval = maxEval;
controls.neps = neps;
[min fval] = samin(loss, init, controls);
