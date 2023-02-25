function [NNdist] = NN1(k,X1, X2, classA, classB)

% Defintion: For a given x you wish to classify, you compute the distance
% between x and all labeled samples, and you assign x the same class as its
% nearest neighbour

% initialize NN_boundary
NNdist = zeros(size(X1));

% classification
for i = 1:size(X1,1)
    for j = 1:size(X1,2)
        
        % Compute distances between sample points and the current point
        Adist = sqrt(sum((classA - [X1(i,j) X2(i,j)]).^2, 2));
        Bdist = sqrt(sum((classB - [X1(i,j) X2(i,j)]).^2, 2));
        
        % Find the k smallest distances
        k_smallest_A = sort(Adist, 'ascend');
        k_smallest_A = k_smallest_A(1:k);
        k_smallest_B = sort(Bdist, 'ascend');
        k_smallest_B = k_smallest_B(1:k);
        
        % Calculate the means of the k smallest distances
        meanA = mean(k_smallest_A);
        meanB = mean(k_smallest_B);
        
        % Assign the label of the nearest neighbor
        if meanA > meanB
            NNdist(i,j) = 1;
        else
            NNdist(i,j) = 0;
        end
        
    end
end

end
