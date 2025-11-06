function plotModel(m, x, y)
%PLOTMODEL  Plot model predictions and optional 95% CI.
%
% USAGE
%   plotModel(m, x, y)
%
% INPUTS
%   m : model struct returned by LinRegress / polyfit / linRegressRegul
%       expected fields: m.theta (p×q or p×1), optionally m.variance, optionally m.n
%   x : input values. Either:
%         - raw column vector (N×1) of the primary independent variable, OR
%         - regressor matrix (N×p) already expanded (including bias if needed)
%   y : observed outputs (N×1)
%
% BEHAVIOR / ASSUMPTIONS
%   * If x is N×p and p matches length(m.theta), it is used directly.
%   * If x is N×1 and length(m.theta)==1, the model is treated as y = theta * x.
%   * If x is N×1 and length(m.theta)>1, the function assumes a polynomial model
%     and expands x with poly_x2(x, degree), where degree = length(theta)-1
%     (i.e., first coefficient is intercept).
%   * If you used polyfit which stores m.n, that takes precedence when expanding.
%   * Confidence intervals use the regressor matrix actually used for prediction.
%
% NOTE
%   This function makes some reasonable assumptions for the common course cases.
%   If you have a multivariate polynomial/regressor setup, pass x already expanded
%   (so the function will not attempt poly expansion).

    % Basic checks
    if nargin < 3
        error('plotModel requires m, x, and y.');
    end
    if size(x,1) ~= size(y,1)
        error('x and y must have the same number of rows (samples).');
    end

    % Ensure theta is column vector for sizing
    theta = m.theta;
    if isrow(theta)
        theta = theta(:);
    end
    p_theta = size(theta,1);
    N = size(x,1);

    % Decide how to build the design/regressor matrix X_use that matches theta
    % CASE A: x already expanded and sizes match -> use it directly
    if size(x,2) == p_theta
        X_use = x;

    % CASE B: x is a single column (raw input) and theta is scalar -> y = theta * x
    elseif size(x,2) == 1 && p_theta == 1
        X_use = x;             % model is simple multiplication

    % CASE C: x is single column and theta length > 1 -> assume polynomial
    % We assume theta has intercept + terms, so degree = p_theta - 1
    elseif size(x,2) == 1 && p_theta > 1
        % Prefer explicit degree if stored in model
        if isfield(m, 'n') && ~isempty(m.n)
            degree = m.n;
        else
            degree = p_theta - 1;   % infer degree (assumes intercept present)
        end
        % poly_x2 should produce an N x p matrix where p = number of basis terms
        % (implementation from course). If your poly_x2 orders terms differently,
        % you may need to adapt this logic.
        X_use = poly_x2(x, degree);

        % Validate size
        if size(X_use,2) ~= p_theta
            warning('Inferred design size (%d) differs from theta length (%d). Using X_use anyway.', ...
                size(X_use,2), p_theta);
            % proceed — user may have different ordering/terms
        end

    % CASE D: x has fewer columns than theta but more than 1 (multivariate unexpanded)
    else
        % If x has fewer cols than theta, try adding bias column if that matches:
        if size(x,2) + 1 == p_theta
            X_use = [ones(N,1), x];   % assume need to add intercept
        else
            % We don't know how to expand automatically for general multivariate case.
            error(['Cannot infer regressor matrix for given x and m.theta. ' ...
                   'Either pass x already expanded to match theta, or ensure theta ' ...
                   'and x have compatible sizes.']);
        end
    end

    % For plotting, pick a scalar x_plot for the horizontal axis:
    % If x was raw column, use that. If X_use has a leading ones column, use the second column.
    if size(x,2) == 1
        x_plot = x;                % original raw x
    else
        % If X_use has an intercept column (all ones) in first column, try to pick next col
        if size(X_use,2) > 1 && all(X_use(:,1) == 1)
            x_plot = X_use(:,2);
        else
            % Fall back to first column (user-supplied multivariate; still plotable)
            x_plot = X_use(:,1);
        end
    end

    % Sort by x_plot for clean lines / filling the CI
    [x_plot_sorted, idx] = sort(x_plot);
    X_sorted = X_use(idx, :);
    y_sorted = y(idx, :);

    % Predictions (handles multi-output if theta is matrix)
    yhat_sorted = X_sorted * theta;

    % Create plot
    figure; hold on;
    plot(x_plot_sorted, y_sorted, 'ko', 'DisplayName', 'Data'); % data points

    % If yhat is vector, plot line; if multiple outputs, plot first output
    if size(yhat_sorted,2) > 1
        plot(x_plot_sorted, yhat_sorted(:,1), '-', 'LineWidth', 1.5, 'DisplayName', 'Model (col 1)');
    else
        plot(x_plot_sorted, yhat_sorted, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Model');
    end

    % Confidence interval if available and single-output
    if isfield(m, 'variance') && ~isempty(m.variance) && size(yhat_sorted,2) == 1
        % Ensure variance dimension matches X_sorted
        if size(m.variance,1) == size(X_sorted,2)
            sigma2 = diag(X_sorted * m.variance * X_sorted');   % N×1 vector
            ci = 1.96 * sqrt(sigma2);                          % 95% approx.
            % fill requires column ordering matching sorted x
            fill([x_plot_sorted; flipud(x_plot_sorted)], ...
                 [yhat_sorted - ci; flipud(yhat_sorted + ci)], ...
                 'r', 'FaceAlpha', 0.18, 'EdgeColor', 'none', 'DisplayName', '95% CI');
        else
            warning('m.variance size does not match design matrix columns. Skipping CI.');
        end
    end

    legend show;
    xlabel('x'); ylabel('y');
    title('Model fit (plotModel)');
    hold off;
end