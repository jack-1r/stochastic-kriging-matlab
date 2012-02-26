% Script file: 
%   mseMin.m

% Purpose: This function return the coordinates of the local minimum points on
%   the response surfaces. The number of sub-regions bound a local minimum
%   points is decided by dividing each input axis in half. The SK model and
%   the SA setting are provided as files.

% Record of revisions
%   Date        Programmer      Description of change
%   ========    ==========      =========================================
%   11/06/28    hieutd          Original code.
%   11/07/20    hieutd          Add check to deal with column vector input.

% Define variables:
%   SKmodel: text string - name of the file containing the SK model params
%   SASetting: text string - name of the file containing the SA setting
%   threshold: [1*1] - threshold value to decide whether the minimum is valid

function f = mseMin(SKmodel, maxX, minX, threshold, SASetting)

% import all the setting from the config file
A = importdata(SASetting);
functol = A(2,1);
paramtol = A(3,1);
maxEval = A(4,1);
neps = A(5,1);
nt = A(1,1);

[k d] = size(minX);
if (d == 1)
    minX = reshape(minX, d, k);
    maxX = reshape(maxX, d, k);
end
[k d] = size(minX);
X = [];

% TO-DO: print out the settings and input

div = 2;    % the number of subspace is fixed.
fprintf('=========================================\n');

for i = 1:div^d
    fprintf('--------------------------------------\n');
    fprintf('subspace=%d \n', i);
    % generate the combination needed to iterate the whole subspaces
    res = i;
    com = [];
    for j = 1:d
        com = [mod(res, div) com];
        res = floor(res/div);
    end
    
    % calculate the lower bound --> upper bound for the sub-space
    lb = minX + com.*(maxX-minX)./(div);
    ub = lb + ones(1, d).*(maxX-minX)./(div);
   
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
    [min fval] = samin(loss, init, controls)
    if fval < threshold
        X = [X; min];
    end
end
f = X;