
% testing nlinfit() function

load carbig
tbl = table(Horsepower,Weight,MPG);
X = [tbl.Horsepower tbl.Weight];
Y = tbl.MPG;

modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + ...
                          b(4)*x(:,2).^b(5);

beta0 = [-50 500 -1 500 -1];
%beta0 = [0 0 0 0 0];
beta1 = nlinfit(X, Y, modelfun, beta0)

opts = statset('nlinfit');
opts.MaxIter = 150;
opts.RobustWgtFun = 'bisquare';
opts.TolFun = 1e-9;
beta2 = nlinfit(X, Y, modelfun, beta0, opts)

beta3 = nlinfit(X, Y, modelfun, beta0, opts, "ErrorModel","constant")

[beta4, R, J, CovB, MSE, ErrorModelInfo] = nlinfit(X, Y, modelfun, beta0)