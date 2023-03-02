function applied_map_grid = MAP_clf(grid, X1, X2, mean1, mean2, mean3, cov1, cov2, cov3, prior1, prior2, prior3)

    q0 = inv(cov1) - inv(cov2);
    q1 = 2*mean2*inv(cov2) - 2*mean1*inv(cov1);
    q2 = mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2';
    q3 = log(prior2/prior1);
    q4 = log(det(cov1)/det(cov2));

    % Make new grid for discriminant values 
    discriminant12 = grid;
    discriminant23 = grid;
    discriminant31 = grid;
    applied_map_grid = grid;
    
    q0 = inv(cov1) - inv(cov2);
    q1 = 2*mean2*inv(cov2) - 2*mean1*inv(cov1);
    q2 = mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2';
    q3 = log(prior2/prior1);
    q4 = log(det(cov1)/det(cov2));
    
    % Populate discriminant values
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g12 = xbar*q0*xbar' + q1*xbar' + q2 + 2*q3 + q4;
            discriminant12(i,j) = g12;
        end
    end
    
    q0 = inv(cov3) - inv(cov2);
    q1 = 2*mean2*inv(cov2) - 2*mean3*inv(cov3);
    q2 = mean3*inv(cov3)*mean3' - mean2*inv(cov2)*mean2';
    q3 = log(prior2/prior3);
    q4 = log(det(cov3)/det(cov2));
    
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g23 = xbar*q0*xbar' + q1*xbar' + q2 + 2*q3 + q4;
            discriminant23(i,j) = g23;
        end
    end
    
    q0 = inv(cov3) - inv(cov1);
    q1 = 2*mean1*inv(cov1) - 2*mean3*inv(cov3);
    q2 = mean3*inv(cov3)*mean3' - mean1*inv(cov1)*mean1';
    q3 = log(prior1/prior3);
    q4 = log(det(cov3)/det(cov1));

    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g31 = xbar*q0*xbar' + q1*xbar' + q2 + 2*q3 + q4;
            discriminant31(i,j) = g31;
        end
    end
    
    % Classifiy each grid point using discriminant value
    for i = 1:height(X1)
        for j = 1:width(X2)
            if (discriminant12(i,j) <= 0 && discriminant31(i,j) >= 0)
                applied_map_grid(i,j) = 1;
            elseif (discriminant23(i,j) <= 0 && discriminant12(i,j) >= 0)
                applied_map_grid(i,j) = 2;
            elseif (discriminant31(i,j) <= 0 && discriminant23(i,j) >= 0)
                applied_map_grid(i,j) = 3;
            % else
                % leave value of 0 in the grid, cannot classify point since its
                % the decision boundary
            end
        end
    end
end
