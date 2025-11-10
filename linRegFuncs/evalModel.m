function yhat = evalModel(m, x)
    % If theta is 2D: simple linear model
    if ndims(m.theta) == 2
        yhat = x * m.theta;
        return;
    end

    % theta is d_in x d_out x n
    n = size(m.theta, 3);
    N = size(x,1);
    d_out = size(m.theta, 2);

    yhat = zeros(N, d_out);
    for e = 1:n
        coef = squeeze(m.theta(:,:,e));   % d_in x d_out
        yhat = yhat + (x .^ (e-1)) * coef; % (N x d_in) * (d_in x d_out) -> N x d_out
    end
end