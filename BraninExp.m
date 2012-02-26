function f = BraninExp(x, y)
RandStream.setDefaultStream ...
     (RandStream('mt19937ar','seed',sum(100*clock)));
    f = fBranin(x, y) + normrnd(0,1);
end