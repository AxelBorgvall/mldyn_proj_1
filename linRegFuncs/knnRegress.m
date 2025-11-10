% filepath: c:\Users\axelb\matlabProjects\mldyn_proj_1\linRegFuncs\knnRegress.m
function m = knnRegress(x, y, k)
    % Basic k-NN regressor constructor
    % x: [N, d]
    % y: [N, d_out]
    % k: scalar (number of neighbors)
    if nargin < 3 || isempty(k)
        k = 1;
    end

    if size(x,1) ~= size(y,1)
        error('knnRegress: x and y must have same number of rows.');
    end

    % Ensure column vectors/matrices are doubles
    x = double(x);
    y = double(y);

    % Build struct similar to python dict
    m = struct();
    m.model = 'KNN';
    m.x = x;
    m.y = y;
    m.k = max(1, floor(k));
end