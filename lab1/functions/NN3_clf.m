function [NNdist] = NN3_clf(grid, k, X1, X2, classA, classB, classC)
% Definition: For a given x you wish to classify, you compute the distance
% between x and all labeled samples, and you assign x the same class as its
% nearest neighbour

% initialize NNdist
applied_NN = grid;

% loop over every point in the grid
for i = 1:height(X1)
    for j = 1:width(X2)
        % calculate the distances between the current point and all samples
        point = [X1(i,j), X2(i,j)];
        a_distances = sqrt(sum((classA - point).^2, 2));
        b_distances = sqrt(sum((classB - point).^2, 2));
        c_distances = sqrt(sum((classC - point).^2, 2));
        
        % find the k smallest distances and calculate their means
        [~, sorted_a] = sort(a_distances);
        mean_a = mean(a_distances(sorted_a(1:k)));
        [~, sorted_b] = sort(b_distances);
        mean_b = mean(b_distances(sorted_b(1:k)));
        [~, sorted_c] = sort(c_distances);
        mean_c = mean(c_distances(sorted_c(1:k)));
        
        % assign the label of the nearest neighbor
        mean_distances = [mean_a, mean_b, mean_c];

        if (min(mean_distances) == mean_a)
            applied_NN(i,j) = 1;
        elseif (min(mean_distances) == mean_b)
            applied_NN(i,j) = 2;
        elseif (min(mean_distances) == mean_c)
            applied_NN(i,j) = 3;
        end
        end
        
    end
end

