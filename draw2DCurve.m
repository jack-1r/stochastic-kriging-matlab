% Script file: 
%   draw2DCurve.m

% Purpose: This function draw the prediction curve and the MSE bound
% given the evaluated Stochastic Kriging model.

% Record of revisions
%   Date        Programmer      Description of change
%   ========    ==========      =========================================
%   11/09/01    hieutd          Original code.

% Define variables:
%   SKmodel: text string - name of the file containing the SK model params

function f = draw2DCurve(SKmodel, maxX, minX, X, Y)
K = 1000;    % number of prediction points to draw
XK = (minX:(maxX-minX)/(K-1):maxX)';

[SK_gau mse] = predictCal(XK, SKmodel);

linewidth = 2;
figure;
plot(XK,SK_gau,'b-','LineWidth',linewidth);
hold on;
plot(XK, SK_gau + mse, 'r-', 'LineWidth', linewidth);
hold on;
plot(XK, SK_gau - mse, 'r-', 'LineWidth', linewidth);
hold on;
scatter(X, Y, 'g', 'filled');

f = {0};