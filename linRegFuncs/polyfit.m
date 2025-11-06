
function m = polyfit(x, y, lambda, n)
    % Extend input x to include polynomial terms: [1, x, x^2, ..., x^n] per feature
    N = size(x, 1);
    d = size(x, 2);

    % Create N x d x (n+1) tensor: each x(i,j) raised to p(1), p(2), ..., p(n+1)
    p = reshape(0:n, 1, 1, []);  % 1×1×(n+1)
    powers = x .^ p;             % N×d×(n+1) guaranteed

    % Reshape to N x (d*(n+1))
    x_ext = reshape(powers, N, []);

    % DO NOT TOUCH y — it stays N x 1 (or N x q)
    % y_ext = y;  % not needed

    % Fit regularized regression
    m = linRegressRegul(x_ext, y, lambda);

    % Store degree
    m.n = n;
end