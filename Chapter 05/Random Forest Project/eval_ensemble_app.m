
% Evaluate ensemble and bagged models for motor system
% Name: eval_ensemble_app.m
% Dataset is nl_motor2.xls
% Output: Fitted model performance
% Prior to run this file, the trained model, begged_motor_model, must have been  exported to Workspace.

T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\nl_motor2.xls")

cVol = T.inputVol;
cMSP = T.motorSP;
inputVol = [1; 3; 5; 7; 9];
X = table(inputVol)
%B = begged_motor_model;
B = ensemble_motor_model

Y = B.predictFcn(X)
plot(cVol, cMSP)
hold on
plot(inputVol, Y,"k+")
hold off
grid;

legend(["data",""], ...
  "Location","southeast")
xlabel('Input Voltage (V)');
ylabel('Motor Speed (RPM)');
