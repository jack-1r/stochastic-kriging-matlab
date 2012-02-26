function b = fBranin(x1, x2)
% return Branin function
  a=1;
  b=5.1/(4*pi^2);
  c=5/pi;
  d=6;
  e=10;
  f=1/(8*pi);
b = a*(x2-b*x1^2+c*x1-d)^2+e*(1-f)*cos(x1)+e;