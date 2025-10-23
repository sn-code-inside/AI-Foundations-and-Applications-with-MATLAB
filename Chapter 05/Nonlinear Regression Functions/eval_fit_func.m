
% Evaluate nonlinear fit functions for motor system
% Name: eval_fit_func.m
% Dataset is nl_motor.xls
% Output: Fitted model performance
% Prior to run this file, the fitted model, motor_fit_model, must have been  exported to Workspace.

T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\nl_motor.xls")

cVol = T.inputVol;
cMSP = T.motorSP;
X = [1 3 8 9 12 15 18];

% Use fitlnm() function.... Define the model as Y = a*log(x) + b 
ModelFunc = @(b, x) b(1)*log(x(:, 1)) + b(2)
beta0 = [30 100];                                                   % Refer to Figure 5.63
mdl_2 = fitnlm(cVol, cMSP, ModelFunc, beta0)

Y = feval(mdl_2, X)
plot(motor_fit_model, cVol, cMSP)
hold on
plot(X, Y,"k+")
hold off
grid;
legend(["data","","extrapolated data"], ...
  "Location","southeast")
xlabel('Input Voltage (V)');
ylabel('Motor Speed (RPM)');




