
% using regress() function to do multiple linear regression
% The dataset MFire_Database.mat should be in desired folder

load MFire_Database.mat ds

x1 = ds.FFMC;
x2 = ds.DMC;
x3 = ds.temp;
x4 = ds.wind;
y = ds.FWI;

X = [ones(size(x1)) x1 x2 x3 x4];
[b, ~, ~, ~, stats] = regress(y,X)


