
% Create a new data table to test trained regression tree model with pediction function
load carsmall
cartable = table(Acceleration, Cylinders, Displacement, Horsepower, Model_Year, Weight, Origin)

T = cartable(1:6,:)
yfit = RT_Car_Model.predictFcn(T)

