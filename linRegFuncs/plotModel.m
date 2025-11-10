% filepath: c:\Users\axelb\matlabProjects\mldyn_proj_1\linRegFuncs\plotModel.m
% ...existing code...
function plotModel(m, x, y)
    % Simple 1D plot of data and fitted model
    % Assumes x is Nx1 and y is Nx1 (or NxD, will plot first output)
    if size(x,2) ~= 1
        error('plotModel assumes 1D input x (Nx1).');
    end

    if nargin < 3
        y = [];
    end

    % Use first output column if multiple outputs
    if ~isempty(y) && size(y,2) > 1
        y = y(:,1);
    end

    % Sort input for plotting
    [xs, idx] = sort(x);
    if ~isempty(y)
        ys = y(idx,:);
    end

    % Create fine grid for smooth model curve
    xg = linspace(min(xs), max(xs), 300)';
    try
        yg = evalModel(m, xg); % expects Nx1 input
    catch ME
        error('evalModel failed: %s', ME.message);
    end

    if size(yg,2) > 1
        yg = yg(:,1); % plot only first output
    end

    figure;
    hold on;
    if ~isempty(y)
        scatter(xs, ys, 36, 'b', 'filled');
    end
    plot(xg, yg, '-r', 'LineWidth', 2);
    xlabel('x');
    ylabel('y');
    title('Data and fitted model (1D)');
    legends = {};
    if ~isempty(y)
        legends{end+1} = 'data';
    end
    legends{end+1} = 'model';
    legend(legends, 'Location', 'best');
    grid on;
    hold off;
end
% ...existing code...