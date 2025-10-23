
% Calculate p(Age|Diabetes). p(Glucose|Diabetes), p(BP|Diabetes) and p(BMI|Diabetes)
% Name: CalP_Diabetes.m

pAge = (1/sqrt(2*pi*167.8))*exp(-(41-39.6)^2/(2*167.8))
pGlucose = (1/sqrt(2*pi*1628.2))*exp(-(187-131.6)^2/(2*1628.2))
pBP = (1/sqrt(2*pi*139.2))*exp(-(68-68)^2/(2*139.2))
pBMI = (1/sqrt(2*pi*47.6))*exp(-(37.7-32.46)^2/(2*47.6))

%Classification for Diabetes
pDiabetes = 0.5*pAge*pGlucose*pBP*pBMI      % 8.6421e-08

%Classification for Non Diabetes
pAge = (1/sqrt(2*pi*99.8))*exp(-(41-34.8)^2/(2*99.8))
pGlucose = (1/sqrt(2*pi*1344.2))*exp(-(187-128.4)^2/(2*1344.2))
pBP = (1/sqrt(2*pi*225))*exp(-(68-71.2)^2/(2*225))
pBMI = (1/sqrt(2*pi*48))*exp(-(37.7-30.92)^2/(2*48))

pNDiabetes = 0.5*pAge*pGlucose*pBP*pBMI     % 4.6333e-08

% Conclusion:
% Since the posterior numerator on Diabetes is 8.6421e-08, which is greater than the posterior on Non Diabetes 4.6333e-08,
% Therefore prediction is that the sample is Diabetes.