
% Using fitrtree() func to create regression tree model
% The dataset is carsmall
% Three different models are generated, tree, tree1 and tree2

load carsmall  
X = [Acceleration, Weight, Cylinders, Horsepower];
tree = fitrtree(X, MPG,...
                          'CategoricalPredictors',4, 'MinParentSize',20,...
                          'PredictorNames',{'A', 'W','C', 'H'}, 'ResponseName', 'MPG', 'CrossVal','on')

tree1 = fitrtree([Weight, Acceleration], MPG,...
                          'CategoricalPredictors',2, 'MinParentSize',20,...
                          'PredictorNames',{'W','A'},'ResponseName', 'MPG')

XX = [4000 8; 4000 15; 4000 20];
MPGpred = predict(tree1, XX)

XXX = [Cylinders, Horsepower, Displacement];
tree2 = fitrtree(XXX, MPG, 'CrossVal', 'on')
numBranches = @(x)sum(x.IsBranch);
tree2NumSplits = cellfun(numBranches, tree2.Trained);

figure;
histogram(tree2NumSplits)

view(tree2.Trained{1},'Mode','graph')
        