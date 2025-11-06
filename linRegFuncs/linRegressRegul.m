function m = linRegressRegul(x, y, lambda)
%LINREGRESSREGUL  Linear regression with L2 regularization (ridge regression).
%
%   m = linRegressRegul(x, y, lambda)
%
%   INPUTS:
%     x : input matrix (N×p)
%     y : output matrix (N×q)
%     lambda : regularization parameter (scalar ≥ 0)
%
%   OUTPUT:
%     m : structure (same as LinRegress output)
%
%   The objective function minimized is:
%       Σ (y(k) - x(k,:)*theta)^2  +  λ * (theta'*theta)
%
%   Implementation trick:
%     We can rewrite this as a normal least squares problem by appending
%     sqrt(lambda)*I to x and zeros to y.

    % Extend x and y to include regularization term
    x2 = [x; sqrt(lambda) * eye(size(x,2))];
    y2 = [y; zeros(size(x,2), size(y,2))];
    
    % Call the standard least-squares estimator
    m = linRegress(x2, y2);
end