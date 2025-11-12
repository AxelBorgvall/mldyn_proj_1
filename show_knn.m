
addpath('linRegFuncs');
addpath('canvas_code');
N=100;
Nval=1000;
var=1;

%[x,y]=linearData(N,var);
%[x_val,y_val]=linearData(Nval,var);

[x,y]=linearData(N,var,0);
[x_val,y_val]=linearData(Nval,var,0);

mlin=linRegress(x,y);
mknn=knnRegress(x,y,3);

multiModelPlot({mlin,mknn}, x, y);

%{
addpath('linRegFuncs')

% filepath: c:\Users\axelb\matlabProjects\mldyn_proj_1\linRegFuncs\show_knn.m
% Simple demonstration of knnRegress + evalModel + plotModel

% Generate 1D training data (so plotModel can display)
N = 10000;
x_train = randn(N,1);
% target is sum over features in py test; for 1D this is identity (plus small noise)
y_train = x_train + 0.05*randn(N,1);

% Fit k-NN
k = 3;
m = knnRegress(x_train, y_train, k);

% Query some points
nq = 5;
x_query = randn(nq,1);
pred = evalModel(m, x_query);

disp('Prediction size:');
disp(size(pred));
disp('Predictions:');
disp(pred);
disp('True (sum of query cols):');
disp(sum(x_query,2));

% Plot training data and fitted model (1D)
plotModel(m, x_train, y_train);

%}