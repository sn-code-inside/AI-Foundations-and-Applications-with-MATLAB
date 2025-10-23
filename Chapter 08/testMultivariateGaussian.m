
% testing multivariate Gaussian distribution

mu = [0 0];
Sigma = [0.3 0.35; 0.35 0.98];

x1 = -4:0.2:4;
x2 = -4:0.2:4;
[X1,X2] = meshgrid(x1, x2);
X = [X1(:) X2(:)];

y = mvnpdf(X, mu, Sigma);
y = reshape(y, length(x2), length(x1));

surf(x1, x2, y)
axis([-4 4 -4 4 0 0.4])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
