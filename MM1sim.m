function [Y Vhat] = MM1sim(service_rate, arrival_rate, n, runlength, init)
% simulating customer waiting time in an MM1 queue 
% response surface = expected steady-state waiting time 
% as a function of the service rate (CAN BE COLUMN VECTOR)
% arrival rate MUST BE SCALAR
% n = number of replications at each design point (k*1)
% runlength = number of customers per run MUST BE > 1
% init = cases for how to initialize (see cases below)

if (min(service_rate) < arrival_rate)
    error('Unstable queue.');
end

RandStream.setDefaultStream ...
     (RandStream('mt19937ar','seed',sum(100*clock)));


k = size(service_rate,1); % number of design points
service_mean = 1./service_rate;
arrival_mean = 1/arrival_rate;
load = service_mean / arrival_mean;
% expected steady state wait time
truth = load ./ (service_rate - arrival_rate);

for m = 1:k
    waits(m).n = zeros([n(m) 1]);
end

% simulate without common random numbers
% initialize
switch init
    case 'stationary'
        % initialize in steady state: the wait is zero with 
        % probability = load and conditional on being positive it's 
        % exponential with rate = service_rate - arrival_rate
        emean = 1./(service_rate-arrival_rate);
        for m = 1:k
            waits(m).n = (rand(1,n(m))<repmat(load(m),1,n(m))) ...
                .*exprnd(emean(m),[1 n(m)]);
        end
    case 'mean'
        for m = 1:k
            waits(m).n = repmat(truth(m),1,n(m));
        end
    case 'zero'
        for m = 1:k
            waits(m).n = zeros([1,n(m)]);
        end
end

% compute waiting times
for m = 1:k
    services = exprnd(service_mean(m),[runlength n(m)]);
    arrivals = exprnd(arrival_mean,[runlength n(m)]);
    wait = waits(m).n;
    
    for i = 2:runlength
        wait = max(0,wait+services(i,:)-arrivals(i,:));
        waits(m).n = waits(m).n + wait;
    end
    waits(m).n = waits(m).n/runlength;
end

Y = zeros(k,1);
Vhat = zeros(k,1);
for m = 1:k
    Y(m) = mean(waits(m).n);
    Vhat(m) = var(waits(m).n,0,2)/n(m);
end

