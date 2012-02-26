% Script file: 
%   drawGraph.m

% Purpose: This function draw the prediction surface and the MSE surface
% given the evaluated Stochastic Kriging model.

% Record of revisions
%   Date        Programmer      Description of change
%   ========    ==========      =========================================
%   11/07/25    hieutd          Original code.

% Define variables:
%   SKmodel: text string - name of the file containing the SK model params

function f = drawGraph(SKmodel, maxX, minX, X, Y)

nDim = size(X, 2);

switch nDim
    case 1
        draw2DCurve(SKmodel, maxX, minX, X, Y);
    case 2
        draw3DSurf(SKmodel, maxX, minX, X, Y);
    otherwise
        display('Unable to plot more than 3 dimensions.');
end

f = {0};