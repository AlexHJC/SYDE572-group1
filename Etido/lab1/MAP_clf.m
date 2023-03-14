function applied_map_grid = MAP_clf(grid, X1, X2, mean1, mean2, cov1, cov2, prior1, prior2)

q0 = inv(cov1) - inv(cov2);
q1 = 2*mean2*inv(cov2) - 2*mean1*inv(cov1);
q2 = mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2';
q3 = log(prior2/prior1);
q4 = log(det(cov1)/det(cov2));

% Make new grid for discriminant values 
discriminant = grid;
applied_map_grid = grid;

% Populate discriminant values
for i = 1:height(X1)
    for j = 1:width(X2)
        xbar = [X1(i,j), X2(i,j)];
        g = xbar*q0*xbar' + q1*xbar' + q2 + 2*q3 + q4;
        discriminant(i,j) = g;
    end
end

% Classifiy each grid point using discriminant value
for i = 1:height(X1)
    for j = 1:width(X2)
        if discriminant(i,j) < 0
            applied_map_grid(i,j) = -1;
        elseif discriminant(i,j) > 0 
            applied_map_grid(i,j) = 1;
        % else
            % leave value of 0 in the grid, cannot classify point since its
            % the decision boundary
        end
    end
end


