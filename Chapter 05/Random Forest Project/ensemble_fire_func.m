
% Use ensemble functions to set nonlinear model for forest fire dataset
% Name: ensemble_fire_func.m
% Dataset is MFire_Database.xls
% Output: Ensembled model

% Use fitrensemble() function...
FT = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\MFire_Database.xls")
T = table(FT.FFMC, FT.DMC, FT.DC, FT.temp, FT.wind, FT.BUI, FT.FWI);

% Use simple syntax to define the model
mdl_1 = fitrensemble(T, FT.FWI)

% Use formula to define the model as FWI = FFMC + DMC + temp + wind + BUI 
formula = 'FWI ~ FFMC + DMC + temp + wind + BUI';
mdl_2 = fitrensemble(FT, formula)

% Use Name-Value pair to specify additional options
X = [FT.FFMC FT.DMC FT.DC FT.temp FT.wind FT.BUI];
mdl_3 = fitrensemble(X, FT.FWI, "Method", "Bag", "NumLearningCycles", 120,"NumBins", 50, "CrossVal","on")

% Plot the cumulative 10-fold cross-validated MSE
kfloss = kfoldLoss(mdl_3, 'Mode','cumulative');
figure;
plot(kfloss);
grid;
ylabel('10-fold cross-validated MSE');
xlabel('Learning cycle');
