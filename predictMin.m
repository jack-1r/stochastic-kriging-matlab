% Script file: 
%   predictMin.m

% Purpose: This function calculate the minimum value of the response
% surface

% Record of revisions
%   Date        Programmer      Description of change
%   ========    ==========      =========================================
%   11/07/25    hieutd          Original code.

% Define variables:
%   SKmodel: text string - name of the file containing the SK model params
%   SASetting: text string - name of the file containing the SA setting

function [min fval] = predictMin(SKmodel, ub, lb, SASetting)

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

% TO-DO: print out the settings and input

% calculate the optimum point using SA
init = lb + (ub-lb)./2;
loss = @(x) predictCal(x, SKmodel);

controls.ub = ub;
controls.lb = lb;
controls.nt = nt;
controls.functol = functol;
controls.paramtol = paramtol;
controls.maxEval = maxEval;
controls.neps = neps;
[min fval] = samin(loss, init, controls);
