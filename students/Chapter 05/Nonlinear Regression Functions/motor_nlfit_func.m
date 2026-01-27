
% Use nonlinear fit functions to set nonlinear model for motor system
% Name: motor_nlfit_func.m
% Dataset is nl_motor.xls
% Output: Fitted model

% Use fit() function...
T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\nl_motor.xls")

cVol = T.inputVol;
cMSP = T.motorSP;
ft = fittype('exp1')
fo = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(cVol)],...
               'StartPoint',[1 1]);
mdl_1 = fit(cVol, cMSP, ft, fo)

% Use fitlnm() function.... Define the model as Y = a*log(x) + b 
ModelFunc = @(b, x) b(1)*log(x(:, 1)) + b(2)
beta0 = [30 100];                                                   % Refer to Figure 5.63
mdl_2 = fitnlm(cVol, cMSP, ModelFunc, beta0)

% Use nlinfit() function.... Define model as poly4: Y = p1*x^4 + p2*x^3 + p3*x^2 + p4*x + p5
ModelFunc = @(b, x) b(1)*x(:, 1).^4 + b(2)*x(:, 1).^3 + b(3)*x(:, 1).^2 + b(4)*x(:, 1) + b(5);
beta0 = [0 0 -4 20 50];                                        % Refer to Figure 5.61
%beta0 = [0 0 0 0 0];
mdl_3 = nlinfit(cVol, cMSP, ModelFunc, beta0)

% Use fitlnm() function..., Define the model as Y = a* exp(-((x - b)/c)^2)
ModelFunc = @(b, x) b(1) * exp(-((x(:, 1) - b(2))/b(3)).^2);
beta0 = [200, 10, 20];                                          % Refer to Figure 5.65
mdl_4 = fitnlm(cVol, cMSP, ModelFunc, beta0)


