


%{
    - use lindata var=1, N=[10,100,1000,10000], use linregress, 

    WANT: true vs est param, plot of model vs data, check convergence. Include MSE on validation data. 

    - same as a but with deg 5 poly. compare with linmod. 

    WANT: MSE vs N. Check overfitting vs data or whatever. 

    - alidate the expression for the parameter variance with a Monte Carlo simulation.
    You can do this, eg, by estimating linear models on different data sets with, eg, 10
    data samples in each of them. Then you make a histogram by the parameter estimates.
    The file MonteCarloExample.m illustrate how this can be done. Note the difference
    of this validation from the one you did in Problem 1.a. There you validated that you
    program gave the same variance as the theoretical expression. Here you validate that
    the estimate you obtain has the variance you validated earlier
    
    - ry KNN models on some of the settings above. How many neighbors is good de-
    pending on the noise level and the number of data? Don’t spend a lot on time on
    this, a very approximate answer is enough indicating how thebest number of neighbors
    change when number of data change.

%}

addpath('linRegFuncs');
addpath('canvas_code');

x_train={};
y_train={};

N_values = [10, 100, 1000, 10000];
var = 1;
k=20;
n=1; %degree


m_lin={};
m_knn={};


for i = 1:length(N_values)
    [x, y] = linearData(N_values(i), var);
    x_train{i} = x;
    y_train{i} = y;
end



[x_val,y_val]=linearData(10000,0);

disp('real param: 1.5, 0.5');
disp('')
for i = 1:length(N_values)
    m_lin{i} = polyfit(x_train{i}, y_train{i},0, n);
    
    y_pred = evalModel(m_lin{i}, x_val);
    mse = mean((y_val - y_pred).^2);
    disp(['MSE for linreg, N = ', num2str(N_values(i)),': ', num2str(mse),' est param: ', num2str(m_lin{i}.theta)]);
end

disp('');

for i = 1:length(N_values)
    m_knn{i} = knnRegress(x_train{i}, y_train{i}, k);

    y_pred = evalModel(m_knn{i}, x_val);
    mse = mean((y_val - y_pred).^2);

    disp(['MSE on validation data for N = ', num2str(N_values(i)),'knnreg: ', num2str(mse)]);
end


