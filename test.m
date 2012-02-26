clc;
X = importdata('X')
Y = importdata('Y')
Vhat = importdata('Vhat')
maxX = [10 15]; minX = [-5 0];
fname = SKfiting(X, Y, Vhat, 'SKsetting');
draw3DSurf(fname, maxX, minX, X, Y);