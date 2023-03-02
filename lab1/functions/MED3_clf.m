function applied_med_grid = MED3_clf(grid, X1, X2, mean1, mean2, mean3)

    % Make new grid for discriminant values 
    discriminant12 = grid;
    discriminant23 = grid;
    discriminant31 = grid;
    applied_med_grid = grid;
    
    % Populate discriminant values
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g1 = -mean1*xbar' + 0.5*(mean1*mean1');
            g2 = -mean2*xbar' + 0.5*(mean2*mean2');
            g12 = g1 - g2;
            discriminant12(i,j) = g12;
        end
    end

    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g2 = -mean2*xbar' + 0.5*(mean2*mean2');
            g3 = -mean3*xbar' + 0.5*(mean3*mean3');
            g23 = g2 - g3;
            discriminant23(i,j) = g23;
        end
    end

    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g3 = -mean3*xbar' + 0.5*(mean3*mean3');
            g1 = -mean1*xbar' + 0.5*(mean1*mean1');
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
