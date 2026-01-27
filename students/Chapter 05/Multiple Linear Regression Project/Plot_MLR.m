
% using regress() function to do multiple linear regression
% The dataset MFire_Database.mat should be in desired folder

load MFire_Database.mat ds
x1 = ds.DC;
x2 = ds.BUI;
y = ds.FWI;

X = [ones(size(x1)) x1 x2];
[b, ~, ~, ~, stats] = regress(y,X)

scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):5:max(x1);
x2fit = min(x2):5:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit, x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT;

mesh(X1FIT,X2FIT,YFIT)
xlabel('DC')
ylabel('BUI')
zlabel('FWI')
view(40,30)
hold off
