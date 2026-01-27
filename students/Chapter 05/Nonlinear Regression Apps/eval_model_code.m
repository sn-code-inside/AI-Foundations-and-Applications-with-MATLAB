
% test to evaluate fitting model that is exported from Curve Fitter App
% Name: eval_model_code.m
% Modle name = motor_fit_model
% Input vector = [1 3 8 9 12 15 18]
% Prior to run this file, the fitted model, motor_fit_model, must have been  exported to Workspace.

X = [1 3 8 9 12 15 18]
Y = motor_fit_model(X)
T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\nl_motor.xls")

cVol = T.inputVol
cMSP = T.motorSP
plot(motor_fit_model, cVol, cMSP)
hold on
plot(motor_fit_model, X, Y,"k+")
hold off
grid;
legend(["data","","extrapolated data","fitted curve"], ...
  "Location","southeast")
xlabel('Input Voltage (V)');
ylabel('Motor Speed (RPM)');
