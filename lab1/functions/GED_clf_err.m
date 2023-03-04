function distance = GED_clf_err(X1, mean1, mean2, cov1, cov2)
%     classify GED for every point using only X1
    distance = zeros(length(X1), 1);
    get_dist = @(xbar, cov, mean) sqrt((xbar - mean) * inv(cov) * (xbar - mean)');
    for i = 1:length(X1)
            xbar = X1(i,:);
            distance(i) = get_dist(xbar, cov1, mean1) - get_dist(xbar, cov2, mean2);
    end