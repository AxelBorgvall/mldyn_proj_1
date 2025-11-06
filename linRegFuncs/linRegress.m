function m = linRegress(x, y)
    
    % Check that x and y have the same number of rows (samples)
    if size(x,1) ~= size(y,1)
        error('x and y must have the same number of rows.');
    end
    
    % Compute least squares estimate of parameters using backslash operator
    theta = x \ y;  % Equivalent to: theta = inv(x'*x)*x'*y (but numerically better)
    
    % Predicted outputs
    yhat = x * theta;
    
    % Number of samples and parameters
    n = size(x,1);
    p = size(x,2);
    
    % Compute variance (only if there is a single output variable)
    if size(y,2) == 1
        % Estimate residual variance (σ²)
        sigma2 = sum((y - yhat).^2) / (n - p);
        % Parameter variance-covariance matrix
        variance = sigma2 * inv(x' * x);
    else
        variance = [];  % Skip if multiple outputs
    end
    
    % Store everything in a structure
    m.model = 'LR';
    m.theta = theta;
    m.variance = variance;
end