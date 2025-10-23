
% Using fitlm() function to perform multiple linear regression
% Input: fire dataset
% Output: Regressed model

load MFire_Database.mat ds

x1 = ds.FFMC;
x2 = ds.DMC;
x3 = ds.temp;
x4 = ds.wind;
y = ds.FWI;

X = [ones(size(x1)) x1 x2 x3 x4];
f_mdl = fitlm(X, y)
plot(f_mdl);
grid;