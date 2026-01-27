
% Test to train binary classification model for diabetes
% Name: Diabetes_Func_Project.m
% Input: Diabetes.csv

T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset\\" + ...
                         "Diabetes.csv");
M = 1:668;                    % training data - 668 training data 
N = 669:768;                % testing data - 100 testing data

X = [T.Pregnancies(M, :), T.Glucose(M, :), T.BloodPressure(M,:), T.SkinThickness(M,:), +...
         T.Insulin(M, :), T.BMI(M, :), T.DiabetesPedigreeFunction(M,:), T.Age(M,:)];
Y = T.Outcome(M, :);
TLabel = T.Outcome(N, :);

% Use fitclinear() function to train the model
mdl_1 = fitclinear(X, Y);

% Get testing data XX to perform prediction or classification
XX = [T.Pregnancies(N, :), T.Glucose(N, :), T.BloodPressure(N,:), T.SkinThickness(N,:), +...
           T.Insulin(N, :), T.BMI(N, :), T.DiabetesPedigreeFunction(N,:), T.Age(N,:)];
label1 = predict(mdl_1, XX);
Title = 'The Confusion Chart for fitclinear() function';
figure(1)
plotConfChart(Title, TLabel, label1);           % call confusionchart() to plot confusion chart

% Use fitckernel() function to fit the model
tbl = table(T.Pregnancies(M, :), T.Glucose(M, :), T.BloodPressure(M,:), T.SkinThickness(M,:), +...
                    T.Insulin(M, :), T.BMI(M, :), T.DiabetesPedigreeFunction(M,:), T.Age(M,:));
[mdl_2, FitInfo] = fitckernel(tbl, Y);
label2 = predict(mdl_2, XX);
Title = 'The Confusion Chart for fitckernel() function';
figure(2)
plotConfChart(Title, TLabel, label2);           % call confusionchart() to plot confusion chart

% Use fitcsvm() function to fit the model
mdl_3 = fitcsvm(tbl, Y);
label3 = predict(mdl_3, XX);
Title = 'The Confusion Chart for fitcsvm() function';
figure(3)
plotConfChart(Title, TLabel, label3);           % call confusionchart() to plot confusion chart

% Use fitcknn() function to fit the model
mdl_4 = fitcknn(tbl, Y);
label4 = predict(mdl_4, XX);
Title = 'The Confusion Chart for fitcknn() function';
figure(4)
plotConfChart(Title, TLabel, label4);           % call confusionchart() to plot confusion chart

function[] = plotConfChart(title, tLabel, pLabel)
cm = confusionchart(tLabel, pLabel);
cm.Title = title;
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
end



