% Purpose: Use stochastic kriging to fit the response surface of expected 
%          waiting time in M/M/1 queue 
% Variable Definition:
%       X - Design points
%       Y - Simulation outputs at design points
%       Vhat - Intrinsic variance at design points
%       k - number of design points
%       K - number of prediction points

clc; clear all; close all;

% === >>> Generate evenly distributed design and prediction points:
maxx = 2; minx = 1.1;   % range of utilization
arrival_rate = 1;       % fixed arrival rate
K = 1000;               % number of prediction points 
k = 5;                 % number of design points
runlength = 3000;       % runlength at each design point
C = 960;                % total computation budget
X = (minx:((maxx-minx)/(k-1)):maxx)';               % design points
XK = (minx:((maxx-minx)/(K-1)):maxx)';              % prediction points
 
% === >>> Obtain outputs at design points:
% Effort allocation is proportional to standard deviation
% rho = 1./X;
% ratio = sqrt(4*rho./(1-rho).^4);
% n = ceil(C*ratio/sum(ratio));   % replications at each design point
n = repmat(20, 5, 1);
[Y Vhat] = MM1sim(X,arrival_rate,n,runlength, 2);  % simulate M/M/1 queue

[YK mse] = SK_draw(X, Y, Vhat, XK);
YKu = YK + sqrt(mse);
YKl = YK - sqrt(mse);

% true = arrival_rate./(XK .* (XK - arrival_rate));   % analytic values at prediction points
d = size(X, 2);

% === >>> plot SK fitted surface:

if (d == 1)
    linewidth = 2;
    disp('drawing...')
    figure;
    % plot(XK,true,'k','LineWidth',linewidth);
    % hold on
    plot(XK,YK,'g-','LineWidth',linewidth);
    hold on
    plot(XK,YKu,'r--','LineWidth',linewidth);
    hold on
    plot(XK,YKl,'r--','LineWidth',linewidth);
    hold on
    plot(X,Y,'s');
    legend('stochastic kriging (gauss)',...
            'MSE bound',...
            'Location','NorthEast');
    plot(XK,zeros(K,1),'k-');
    ylabel('average expected waiting time');
    xlabel('service rate');
%    hold off;
end
