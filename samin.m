% Calculate the optimum point using SA method similar to samin routine from 
% Octave
%   loss: function to minimize
%   args: a row vector contain all the function arguments
%   controls: a struct contain all the SA parameters

function [min fval] = samin(loss, args, controls)

def = struct(...
        'lb',...
        'ub',...
        'nt',320,...
        'ns',3,...
        'rt',0.9,...
        'maxEval',75000,...
        'neps',100,...
        'functol',1.0e-5,...
        'paramtol',0.001);

    if ~isstruct(controls)
        error('MATLAB:samin:badOptions',...
            'Input argument ''controls'' is not a structure')
    end
    fs = {'lb','ub','nt','ns','rt','maxEval','neps',...
        'functol','paramtol'};
    for nm=1:length(fs)
        if ~isfield(controls,fs{nm})
            controls.(fs{nm})=def.(fs{nm});
        end
    end


    % main settings
    lb = controls.lb;
    ub = controls.ub;
    nt = controls.nt;
    ns = controls.ns;
    rt = controls.rt;
    maxEval = controls.maxEval;
    neps = controls.neps;
    functol = controls.functol;
    paramtol = controls.paramtol;
    
    x = args;
    bounds = ub - lb;
    n = size(x, 2);
    xopt = x;
    
    % initial values
    nacc = 0;    % total accepted trial
    t = 1000;    % initial temperature
    converge = 0;    % convergence indicator
    coverage_ok = 0;   % search space coverage indicator. When this turns 1
                       % temperature will start to fall
    fstar = 1e9*ones(neps, 1);
                       
    % initial obj_values
    f = loss(args);
    fopt = f;
    feval = 0;
    
    % main loop, first increase temperature until parameter space covered,
    % then reduce until convergence
    while (converge == 0)
        % statistics to report at each temp change, set back to zeros
        nup = 0;
        ndown = 0;
        nrej = 0;
        nnew = 0;
        lnobds = 0;        
        % repeat nt times then adjust temperature
        for m = 1:nt
            nacp = zeros(n, 1);
            % repeat ns times then adjust bounds
            for j = 1:ns
                
                % generate a new points by taking last and adding a random
                % value to each of elements, in turn
                for h = 1:n
                    xp = x;
                    xp(h) = x(h) + (2*rand-1).*bounds(h);
                    if (xp(h)<lb(h)) || (xp(h)>ub(h))
                        xp(h) = lb(h) + (ub(h) - lb(h))*rand;
                        lnobds = lnobds + 1;
                    end
                    
                    % evaluate function at new point
                    fp = loss(xp);
                    feval = feval + 1;
                    
                    % accept the point if the function value decreases
                    if fp<=f
                        x = xp;
                        f = fp;
                        nacc = nacc + 1;
                        nacp(h) = nacp(h) + 1;
                        nup = nup + 1;
                        
                        % if lower than the current fopt then record
                        if fp < fopt
                            fopt = fp;
                            xopt = xp;
                            nnew = nnew + 1;
                        end
                    else
                        % the point is higher, use Metropolis criteria to 
                        % decide
                        p = exp(-(fp-f)/t);
                        if rand < p
                            x = xp;
                            f = fp;
                            nacc = nacc + 1;
                            nacp(h) = nacp(h) + 1;
                            ndown = ndown + 1;
                        else
                            nrej = nrej + 1;
                        end
                    end
                    
                    % if maxEval exceeded then terminate
                    if feval >= maxEval
                        warning('Convergence criteria are not met. maxEval exceeded.');
                        min = xopt;
                        fval = fopt;
                        return
                    end                   
                end
            end
            
            % adjust bounds so that approximately half of all evaluations
            % are accepted
            test = 0;
            for i = 1:n
                ratio = nacp(i)/ns;
                if ratio>0.6
                    bounds(i) = bounds(i) * (1.0 + 2.0 * (ratio - 0.6) / 0.4);
                elseif ratio<0.4
                    bounds(i) = bounds(i) / (1.0 + 2.0 * ((0.4 - ratio) / 0.4));                  
                end
                % keep within initial bounds
                if bounds(i) > (ub(i) - lb(i))
                    bounds(i) = ub(i) - lb(i);
                    test = test + 1;
                end
            end 
            if ~coverage_ok, coverage_ok = (test == n); end            
        end
        
        % check for convergence, if we have cover the params space
        if (coverage_ok)
            % last value close enough to neps value?
            fstar(1) = f;
            test = 0;
            for i = 1:neps
                test = test + (abs(f - fstar(i))>functol);
            end

            test = (test > 0);  % conv. failed if test > 0
            % last value close enough to overall best
            if (abs(fopt - f) <= functol) && (~test)
                for i = 1:n
                    if bounds(i) > paramtol
                        converge = 0;   % no conv. if bounds too wide
                        break;
                    else
                        converge = 1;
                    end
                end
            end

            if (converge > 0)
                min = xopt;
                fval = fopt;
                return
            end
            
            % reduce the temp, record function value in the neps list and
            % loop again
            t = rt*t;
            for i = neps:-1:2
                fstar(i) = fstar(i-1);
            end
            f = fopt;
            x = xopt;
        else
            % increase the temp to quickly cover the params space
            t = t^2;
            for i = neps:-1:2
                fstar(i) = fstar(i-1);
            end
            f = fopt;
            x = xopt;
        end
        
    end
    
    
    