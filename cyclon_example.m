% Use stochastic kriging to fit the response surface of the cyclon
% randomness experiment.
%   k: number of design points.
%   K^2: number of prediction points. Note that the prediction points should
%       be generated using a mesh-grid pattern in order to draw graph
%   X: [k * 2] design points matrix
%   XK: [K^2 * 2] prediction points matrix

clc; clear all; close all;
A = importdata('result.log')

% Define the exp domain
maxX = [40 15] ; minX = [20 1];

k = size(A,1)
X = [A(1:k,1) A(1:k,2)]
Y = A(1:k,3)
Vhat = A(1:k,4)

% Use mesh-grid function to generate the prediction points
K = 50; % number of prediction points
[Xp Yp] = meshgrid(minX(1):((maxX(1) - minX(1))/(K-1)):maxX(1),...
    minX(2):((maxX(2) - minX(2))/(K-1)):maxX(2));
XK = [reshape(Xp, [K^2 1]) reshape(Yp, [K^2 1])];

B = repmat(1, [k 1]);   % basis function matrix at design points
% q = 0;  % degree of polynomial to fit in regression part(default)
% B = repmat(X,[1 q+1]).^repmat(0:q,[k 1]) 
BK = repmat(1, [K^2 1]);


% produce the SK prediction surface
skriging_model = SKfit(X,Y,B,Vhat,2);
[SK_gau mse] = SKpredict(skriging_model,XK,BK);

% reshape the results into graph-compatible form
SKp = reshape(SK_gau, [K K]);
msep = reshape(mse, [K K]);

% draw all the graph
subplot(1, 2, 1);
mesh(Xp, Yp, SKp, (SKp - SKp));
hold on;
scatter3(X(1:k,1), X(1:k,2), Y, 'filled');
title('SK prediction surface','FontWeight', 'bold');

subplot(1, 2, 2);
surface(Xp, Yp, SKp, msep);
title('SK surface with regard to predicted MSE','FontWeight', 'bold');
colorbar;

