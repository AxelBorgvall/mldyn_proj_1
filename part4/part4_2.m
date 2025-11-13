addpath('linRegFuncs');
addpath('canvas_code');
%{
2*1=2
depending on wether "linear" is actually linear or includes a constant
2*1*4=8
%}

N_train=1000;
var=1;
N_val=10000;
n=3

[x,y]=twoDimData2(N,var);
[xv,yv]=twoDimData2(N,0);

%IT WAS CORRECT!!!!!!!!!!!!!!
%{

m_lin=LinRegress(x,y);
m_pol=polyfit(x,y,0,3);
size(m_pol.theta)
size(m_lin.theta)
%}


disp('');
m_lin = linRegressRegul(x, y,0);

y_pred = evalModel(m_lin, xv);
mse = mean((yv - y_pred).^2);
disp(['MSE for linreg, N = ', num2str(N),': ', num2str(mse),' est param: ']);
disp(num2str(m_lin.theta))



disp('');


polymod= polyfit(x, y,0,3);
y_pred = evalModel(polymod, xv);
mse = mean((yv - y_pred).^2);
disp(['MSE for polyfit, N = ', num2str(N),': ', num2str(mse),' est param: ']);
disp(num2str(polymod.theta))
