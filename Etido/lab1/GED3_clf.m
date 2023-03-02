function applied_med_grid = GED3_clf(grid, X1, X2, mean1, mean2, mean3, cov1, cov2, cov3)

    % Make new grid for discriminant values 
    discriminant12 = grid;
    discriminant23 = grid;
    discriminant31 = grid;
    applied_med_grid = grid;
    
    % Populate discriminant values
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            invcov1 = inv(cov1);
            invcov2 = inv(cov2);
            g1 = (xbar - mean1) * invcov1 * transpose(xbar - mean1);
            g2 = (xbar - mean2) * invcov2 * transpose(xbar - mean2);
            g12 = g1 - g2;
            discriminant12(i,j) = g12;
        end
    end

    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            invcov2 = inv(cov2);
            invcov3 = inv(cov3);
            g2 = (xbar - mean2) * invcov2 * transpose(xbar - mean2);
            g3 = (xbar - mean3) * invcov3 * transpose(xbar - mean3);
            g23 = g2 - g3;
            discriminant23(i,j) = g23;
        end
    end

    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            invcov3 = inv(cov3);
            invcov1 = inv(cov1);
            g3 = (xbar - mean3) * invcov3 * transpose(xbar - mean3);
            g1 = (xbar - mean1) * invcov1 * transpose(xbar - mean1);
            g31 = g3 - g1;
            discriminant31(i,j) = g31;
        end
    end
    
    % Classifiy each grid point using discriminant value
    for i = 1:height(X1)
        for j = 1:width(X2)
            if (discriminant12(i,j) <= 0 && discriminant31(i,j) >= 0)
                applied_med_grid(i,j) = 1;
            elseif (discriminant23(i,j) <= 0 && discriminant12(i,j) >= 0)
                applied_med_grid(i,j) = 2;
            elseif (discriminant31(i,j) <= 0 && discriminant23(i,j) >= 0)
                applied_med_grid(i,j) = 3;
            % else
                % leave value of 0 in the grid, cannot classify point since its
                % the decision boundary
            end
        end
    end
end
