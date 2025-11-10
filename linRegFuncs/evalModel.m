% filepath: c:\Users\axelb\matlabProjects\mldyn_proj_1\linRegFuncs\evalModel.m
function yhat = evalModel(m, x)
    % Support KNN model structs
    if isfield(m, 'model') && strcmp(m.model, 'KNN')
        % x: [Nq, d], m.x: [Ntrain, d], m.y: [Ntrain, d_out]
        if size(x,2) ~= size(m.x,2)
            error('evalModel (KNN): query x and training x must have same number of columns.');
        end
        k = 1;
        if isfield(m, 'k') && ~isempty(m.k)
            k = m.k;
        end
        Nq = size(x,1);
        Ntrain = size(m.x,1);
        k = min(k, Ntrain);

        % Compute squared distances: D(i,j) = ||x(i,:) - m.x(j,:)||^2
        % vectorized: ||a-b||^2 = sum(a.^2,2) + sum(b.^2,2)' - 2*a*b'
        D = bsxfun(@plus, sum(x.^2,2), sum(m.x.^2,2)') - 2*(x * m.x');

        % Sort each row to find nearest neighbors
        [~, idx] = sort(D, 2, 'ascend');
        idx = idx(:, 1:k);  % Nq x k

        % Average neighbors' outputs
        d_out = size(m.y, 2);
        yhat = zeros(Nq, d_out);
        for i = 1:Nq
            neighIdx = idx(i, :);
            yhat(i, :) = mean(m.y(neighIdx, :), 1);
        end
        return;
    end

    % ...existing code...
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