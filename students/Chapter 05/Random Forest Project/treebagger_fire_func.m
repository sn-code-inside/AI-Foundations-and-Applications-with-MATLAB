
% Use TreeBagger() functions to set random forest model for forest fire dataset
% Name: treebagger_fire_func.m
% Dataset is MFire_Database.xls
% Output: Random forest model

% Use TreeBagger() function...
FT = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\MFire_Database.xls");
T = table(FT.FFMC, FT.DMC, FT.DC, FT.temp, FT.wind, FT.BUI, FT.FWI);

% Use simple syntax to define the model for random forest
mdl_1 = TreeBagger(100, T, FT.FWI, Method="regression")

% Use formula to define the model as FWI = FFMC + DMC + temp + wind + BUI 
formula = "FWI ~ FFMC + DMC + temp + wind + BUI";
mdl_2 = TreeBagger(100, FT, formula, Method="regression", NumPredictorsToSample=50)

% Use constrcutor 3 to set the model
mdl_3 = TreeBagger(50, FT, FT.FWI, Method="regression")

% Use Name-Value pair to specify additional options
X = FT.BUI;
Y = FT.FWI;
mdl_4 = TreeBagger(200, X, Y, Method="regression", OOBPredictorImportance="on", MinLeafSize=4)

predX = linspace(min(X),max(X),10)';
YMean = predict(mdl_4,predX);
YQuartiles = quantilePredict(mdl_4, predX, Quantile=[0.25, 0.5, 0.75]);
hold on
plot(X,Y,"o");
plot(predX,YMean);
plot(predX,YQuartiles);
hold off
ylabel("Fire Weather Index Values");
xlabel("Buildup Index Values");
legend("Data","Mean Response","First Quartile","Median", "Third Quartile");

