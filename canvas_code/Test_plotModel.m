addpath('../linRegFuncs');

% This m-files  tests your functions 
% plotModel, LinRegress, polyfit, knnRegress
%
% it generates three plots and they should be identical to the plots in
% the appendix of  project 1 instructions, if everything is correct.

close all

% Estimation data
x=(-5:0.5:5)';

% linear function plus noise
y=3+1.5*sin(x)+real((-1).^x);


m=LinRegress(x,y);
poly = polyfit(x,y,0,4);
knn = knnRegress(x,y,3);

x2=(-5:0.1:5)';
figure
plotModel(m,x,y)

figure
%plotModel(x,y,m,poly,knn)

multiModelPlot({poly,knn},x,y);

figure
plotModel(poly,x,y)
