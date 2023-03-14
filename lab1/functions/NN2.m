function [NNdist] = NN2(k, X1, X2, classA, classB, classC)
%NN Calculate the K Nearest Neighbours for two or three classes

% Definition: For a given x you wish to classify, you compute the distance
% between x and all labeled samples, and you assign x the same class as its
% nearest neighbour

% initialize NNdist
NNdist = zeros(size(X1));

% loop over every point in the grid
for i = 1:size(X1, 1)
    for j = 1:size(X1, 2)
        
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
        if mean_a > mean_b && mean_a > mean_c
            NNdist(i,j) = 1;
        elseif mean_b > mean_a && mean_b > mean_c
            NNdist(i,j) = 2;
        else
            NNdist(i,j) = 3;
        end
        
    end
end
end
