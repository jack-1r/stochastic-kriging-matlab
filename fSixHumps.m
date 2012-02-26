function s = fSixHumps(x1, x2)
% evaluate the six-hump camel back function
s = (4 - 2.1 * x1^2 + 1/3 * x1^4) * x1^2 + x1 * x2 + (-4 + 4 * x2^2) * x2^2;