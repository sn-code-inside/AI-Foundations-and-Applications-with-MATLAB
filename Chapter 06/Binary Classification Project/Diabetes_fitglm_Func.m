
% Test to train binary classification model for diabetes using function fitglm()
% Name: Diabetes_fitglm_Func.m
% Input: Diabetes.csv

T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset\\" + ...
                         "Diabetes.csv");
M = 1:668;                    % training data - 668 training data 
N = 669:768;                % testing data - 100 testing data

X = [T.Pregnancies(M, :), T.Glucose(M, :), T.BloodPressure(M,:), T.SkinThickness(M,:), +...
         T.Insulin(M, :), T.BMI(M, :), T.DiabetesPedigreeFunction(M,:), T.Age(M,:)];

% Get testing data XX to perform prediction or classification
XX = [T.Pregnancies(N, :), T.Glucose(N, :), T.BloodPressure(N,:), T.SkinThickness(N,:), +...
           T.Insulin(N, :), T.BMI(N, :), T.DiabetesPedigreeFunction(N,:), T.Age(N,:)];

Y = T.Outcome(M, :);
TLabel = T.Outcome(N, :);

% Use fitglm() function to fit the model
mdl_5 = fitglm(X, Y);
label5 = predict(mdl_5, XX);

for n = 1:100
    if label5(n) >= 0.5
       label5(n) = 1;
    else
        label5(n) = 0;
    end
end

AA = label5 == TLabel;
result = nnz(AA)

m = 1:100;
figure(1)
plot(m, label5, 'bo', m, TLabel, 'r*');
title('Perform binary classification using fitglm() function');
legend('fitglm() values', 'Test values', 'location', 'west');
axis([0 100 0 1.2]);
grid;
figure(2)
cm = confusionchart(TLabel, label5);
cm.Title = 'Binary Classification With fitglm() Function';
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';







