
function m = polyfit(x, y, lambda, n)
    n=n+1;
    % x: [N, d_in]
    % y: [N, d_out]
    % lambda: scalar
    % n: number of polynomial terms (powers 0..n-1)

    N = size(x,1);
    d = size(x,2);

    % powers 0..(n-1)
    p = reshape(0:(n-1), 1, 1, []);  % 1x1xn

    % Create N x d x n tensor of x.^p
    powers = x .^ p;  % N x d x n

    % Reshape to N x (d*n)
    x_ext = reshape(powers, N, []);

    % Fit regularized regression
    m = linRegressRegul(x_ext, y, lambda);

    % Reshape theta from (d*n) x d_out to d x d_out x n (matching Python)
    d_out = size(m.theta, 2);
    m.theta = reshape(m.theta, d, n, d_out);   % d x n x d_out
    m.theta = permute(m.theta, [1 3 2]);       % d x d_out x n

    % Store polynomial degree
    m.n = n;
end