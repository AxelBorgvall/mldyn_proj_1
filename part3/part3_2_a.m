%{
2. 
    - repeat previous linfit to polydata(N,var,0). Does the parameter uncertainty go to 0? Explain how it can do that. 
    - try various degrees of polymodels, try a 10 d model on N=15. try lambda=[0.01,0.1,...,100] compare result(note to self fix multiplot and use). 
    - call polydata(N,var,1) for unsymmetrical data. Do linfit, compare to previous linfit, is it different? is that an issue?
    - Try some KNN. k dependecy on noise+N? keep it short.

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
    [x, y] = polyData(N_values(i), var,0);
    x_train{i} = x;
    y_train{i} = y;
end



[x_val,y_val]=polyData(1000,0);
%{
TRUE POLYDATA FUNCTION
if nargin==2, sym=0; end;

if sym==1,
  x=[rand(round(0.9*N),1)*5;5+rand(round(0.1*N),1)*5];
else
 x=rand(N,1)*10;
end

y=10*(.5-3.2*(x/10)+1*(x/10).^2+5*(x/10).^3-4*(x/10).^4)+sqrt(var)*randn(N,1);

%}
disp('true param: 0.5, -0.32, 0.01, 0.005, -0.0004');

disp('');
for i = 1:length(N_values)
    m_lin{i} = polyfit(x_train{i}, y_train{i},0, n);
    
    y_pred = evalModel(m_lin{i}, x_val);
    mse = mean((y_val - y_pred).^2);
    disp(['MSE for linreg, N = ', num2str(N_values(i)),': ', num2str(mse),' est param: ', num2str(m_lin{i}.theta), ' variance: ']);
    disp(num2str(m_lin{i}.variance));
end

disp('');

for i = 1:length(N_values)
    m_knn{i} = knnRegress(x_train{i}, y_train{i}, k);

    y_pred = evalModel(m_knn{i}, x_val);
    mse = mean((y_val - y_pred).^2);

    disp(['MSE on validation data for N = ', num2str(N_values(i)),' knnreg: ', num2str(mse)]);
end


