function applied_ged_grid = GED_clf(grid, X1, X2, mean1, mean2, cov1, cov2)

    % Make new grid for discriminant values 
    discriminant = grid;
    applied_ged_grid = grid;
    
    % Populate discriminant values
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            invcov1 = inv(cov1);
            invcov2 = inv(cov2);
            g1 = (xbar - mean1) * invcov1 * transpose(xbar - mean1);
            g2 = (xbar - mean2) * invcov2 * transpose(xbar - mean2);
            g = g1 - g2;
            discriminant(i,j) = g;
        end
    end
    
    % Classifiy each grid point using discriminant value
    for i = 1:height(X1)
        for j = 1:width(X2)
            if discriminant(i,j) < 0
                applied_ged_grid(i,j) = -1;
            elseif discriminant(i,j) > 0 
                applied_ged_grid(i,j) = 1;
            % else
                % leave value of 0 in the grid, cannot classify point since its
                % the decision boundary
            end
        end
    end
end