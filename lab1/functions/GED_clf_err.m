function applied_ged_grid_err = GED_clf_err(grid, X1, mean1, mean2, cov1, cov2)

    % Make new grid for discriminant values 
    discriminant = grid;
    applied_ged_grid_err = grid;
    
    % Populate discriminant values
    for i = 1:height(X1)
            xbar = X1;
            invcov1 = inv(cov1);
            invcov2 = inv(cov2);
            g1 = (xbar - mean1) * invcov1 * transpose(xbar - mean1);
            g2 = (xbar - mean2) * invcov2 * transpose(xbar - mean2);
            g = g1 - g2;
            discriminant(i,1i) = g;
    end