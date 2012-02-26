% This is an example for the use of simulated annealing to identify the 
% minima of the mse function

clc; clear all; close all;

% Define the exp domain and sample it using LHS
maxX = [10 15];
minX = [-5 0];
k = 15;
B = lhsdesign(k, 2);

min = repmat(minX, [k 1]);
max = repmat(maxX, [k 1]);
X = min + (max - min).*B;
n = repmat(10, [k,1]);
[Y Vhat] = procBranin(X, n, 'norm');

B = repmat(1, [k 1]);   % basis function matrix at design points
skriging_model = SKfit(X,Y,B,Vhat,2);

init = (maxX + minX)./2

% dummy = 1;
% nb = init;
% next = @(x) neighbor(x, maxX, minX)
% while dummy==1
%     nb = next(nb)
% end

% test = mse(init, skriging_model)

% loss = @(x) fBranin(x(1), x(2));
loss = @(x) mse(x, skriging_model);
% options.Generators = @(x) neighbor(x, maxX, minX);
% [min fval] = anneal(loss, init, options)

controls.ub = maxX;
controls.lb = minX;
% controls.functol = 10;
controls.paramtol = 0.1;
controls.maxEval = 750000;
controls.neps = 10;
[min fval] = samin(loss, init, controls)