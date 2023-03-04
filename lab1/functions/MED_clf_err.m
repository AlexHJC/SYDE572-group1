function distance = MED_clf_err(X1, mean1, mean2)
%     classify MED for every point using only X1
    distance = zeros(length(X1), 1);
    get_dist = @(xbar, mean) sqrt((xbar-mean) * (xbar-mean)');
    for i = 1:length(X1)
            xbar = X1(i,:);
            distance(i) = get_dist(xbar, mean1) - get_dist(xbar, mean2);
    end
end
