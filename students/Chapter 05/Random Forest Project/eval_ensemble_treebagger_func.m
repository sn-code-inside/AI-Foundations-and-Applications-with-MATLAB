
% Evaluate ensemble and treebagger models with predict() function
% Nam: eval_ensemble_treebagger_func.m
% Input: MFire_Databse.xls

FT = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\MFire_Database.xls");

% Use ensemble tree algorithm to train the model
X = [FT.FFMC FT.DMC FT.DC FT.temp FT.wind FT.BUI];
mdl_1 = fitrensemble(X, FT.FWI)
FWI_1 = predict(mdl_1, [70 60 715 25 2.9 125])

% Use formula to define the model as FWI = FFMC + DMC + temp + wind + BUI 
formula = "FWI ~ FFMC + DMC + temp + wind + BUI";
mdl_2 = TreeBagger(100, FT, formula, Method="regression", NumPredictorsToSample=50)
FWI_2 = predict(mdl_2, [70 60 25 2.9 125])

rsLoss = resubLoss(mdl_1, 'Mode', 'Cumulative');
plot(rsLoss);
xlabel('Number of Learning Cycles');
ylabel('Resubstitution Loss');
grid;


