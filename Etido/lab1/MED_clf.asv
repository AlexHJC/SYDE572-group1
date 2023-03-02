function applied_med_grid = MED_clf(grid, X1, X2, mean1, mean2)

% Make new grid for discriminant values 
discriminant = grid;
applied_med_grid = grid;

% Populate discriminant values
for i = 1:height(X1)
    for j = 1:width(X2)
        xbar = [X1(i,j), X2(i,j)];
        g1 = -mean1*xbar' + 0.5*(mean1*mean1');
        g2 = -mean2*xbar' + 0.5*(mean2*mean2');
        g = g1 - g2;
        discriminant(i,j) = g;
    end
end

% Classifiy each grid point using discriminant value
for i = 1:height(X1)
    for j = 1:width(X2)
        if discriminant(i,j) < 0
            applied_med_grid(i,j) = -1;
        elseif discriminant(i,j) > 0 
            applied_med_grid(i,j) = 1;
        % else
            % leave value of 0 in the grid, cannot classify point since its
            % the decision boundary
        end
    end
end