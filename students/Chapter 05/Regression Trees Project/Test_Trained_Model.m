
% Create a new data table to test trained regression tree model with pediction function

Acceleration = 18;
Cylinders = 8;
Displacement = 320;
Horsepower = 150;
Model_Year = 70;
Weight = 3804;
Origin = "USA";

T = table(Acceleration, Cylinders, Displacement, Horsepower, Model_Year, Weight, Origin)
yfit = RT_Car_Model.predictFcn(T)
