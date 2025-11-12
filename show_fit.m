addpath('linRegFuncs');
addpath('canvas_code');
N=100;
Nval=1000;
var=1;

%[x,y]=linearData(N,var);
%[x_val,y_val]=linearData(Nval,var);

[x,y]=polyData(N,var,0);
[x_val,y_val]=polyData(Nval,var,0);

m=polyfit(x,y,0,3);

plotModel(m,x,y);


%{
% Parameters (match py_test_1)
N = 20;
d_in = 3;
d_out = 2;
n = 3;

xvar = 5;
yvar = 5;
lam = 0;

% Create inputs
x = sort(rand(N, d_in) * xvar * 2 - xvar, 1);  % sort each column

% Create random polynomial coefficients theta sized [d_in, d_out, n]
theta = rand(d_in, d_out, n);

% Build outputs y as sum over exponents 0..n-1 of theta(:,:,e) .* x.^exponent
y = zeros(N, d_out);
for e = 1:n
    y = y + (x .^ (e-1)) * squeeze(theta(:,:,e));
end

% Fit polynomial model
m = polyfit(x, y, lam, n);

% Display shapes and mean error
disp('theta (true) size:');
disp(size(theta));
disp('m.theta size:');
disp(size(m.theta));

err_mean = mean(y - evalModel(m, x), 'all');
disp('mean error (y - evalModel):');
disp(err_mean);

disp(m.model);
%}

%{
N = 20;
d_in = 1;
d_out = 1;
n_dat = 5;
n_mod=3;

xvar = 5;
yvar = 5;
lam = 0;

% Create inputs
x = sort(rand(N, d_in) * xvar * 2 - xvar, 1);  % sort each column

% Create random polynomial coefficients theta sized [d_in, d_out, n]
theta = rand(d_in, d_out, n_dat);

% Build outputs y as sum over exponents 0..n-1 of theta(:,:,e) .* x.^exponent
y = zeros(N, d_out);
for e = 1:n_dat
    y = y + (x .^ (e-1)) * squeeze(theta(:,:,e));
end

m=polyfit(x,y,lam,n_mod);

plotModel(m,x,y);



%}