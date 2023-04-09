function applied_med_grid = MED_clf(mean_a, mean_b, X, Y)

    % modified MED function for lab 2 section 4

    applied_med_grid = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, mean) (point-mean) * (point-mean)';

    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            point = [X(i, j) Y(i, j)];
            applied_med_grid(i, j) = get_dist(point, mean_a) - get_dist(point, mean_b);
        end
    end
    
end