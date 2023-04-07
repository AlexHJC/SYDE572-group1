function applied_ML_grid = ML2D(grid, X1, X2, mean1, mean2, mean3, cov1, cov2, cov3)

    % Make new grid for discriminant values 
    discriminant12 = grid;
    discriminant23 = grid;
    discriminant31 = grid;
    applied_ML_grid = grid;

    % Populate discriminant values
    for i = 1:height(X1)
        for j = 1:width(X2)
            xbar = [X1(i,j), X2(i,j)];
            g12 = xbar*(inv(cov2)-inv(cov1))*xbar' + ((2*mean1*inv(cov1))-(2*mean2*inv(cov2)))*xbar' + mean2*inv(cov2)*mean2' - mean1*inv(cov1)*mean1';
            discriminant12(i,j) = g12;
            g23 = xbar*(inv(cov3)-inv(cov2))*xbar' + ((2*mean2*inv(cov2))-(2*mean3*inv(cov3)))*xbar' + mean3*inv(cov3)*mean3' - mean2*inv(cov2)*mean2';
            discriminant23(i,j) = g23;
            g31 = xbar*(inv(cov1)-inv(cov3))*xbar' + ((2*mean3*inv(cov3))-(2*mean1*inv(cov1)))*xbar' + mean1*inv(cov1)*mean1' - mean3*inv(cov3)*mean3';
            discriminant31(i,j) = g31;
        end
    end

    % Classifiy each grid point using discriminant value
    for i = 1:height(X1)
        for j = 1:width(X2)
            if (discriminant12(i,j) >= 0 && discriminant31(i,j) <= 0)
                applied_ML_grid(i,j) = 1;
            elseif (discriminant23(i,j) >= 0 && discriminant12(i,j) <= 0)
                applied_ML_grid(i,j) = 2;
            elseif (discriminant31(i,j) >= 0 && discriminant23(i,j) <= 0)
                applied_ML_grid(i,j) = 3;
            % else
                % leave value of 0 in the grid, cannot classify point since its
                % the decision boundary
            end
        end
    end

% Plot results
contour(X1, X2, applied_ML_grid, 'color', 'black');
hold on;
xlabel('x1');
ylabel('x2');

end
