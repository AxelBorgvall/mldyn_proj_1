function m = linRegressRegul(x, y, lambda)
    % Extend x and y to include regularization term
    x2 = [x; sqrt(lambda) * eye(size(x,2))];
    y2 = [y; zeros(size(x,2), size(y,2))];
    
    % Call the standard least-squares estimator
    m = linRegress(x2, y2);
end