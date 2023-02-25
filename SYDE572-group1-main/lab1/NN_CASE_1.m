function [NN_boundary] = NN_CASE_1(k, sampleA, sampleB, X1, Y1)
%for a given point you wish to classify, compute the distance between that sample
%point and all labeled samples, and assign the point the same class as its
%nearest neighbour.

%CASE 1
samples = [sampleA; sampleB];
distances = pdist2(samples, [X1(:), Y1(:)]);
distances_A = distances(1:size(sampleA, 1), :);
distances_B = distances(size(sampleA, 1)+1:end, :);

NN_boundary = reshape(distances_A < distances_B, size(X1));

if k > 1
    [~, sorted_indices_A] = sort(distances_A);
    [~, sorted_indices_B] = sort(distances_B);
    NN_boundary = zeros(size(X1));
    for i = 1:size(X1, 1)
        for j = 1:size(X1, 2)
            if sum(sorted_indices_A(:, j) == i) >= k || sum(sorted_indices_B(:, j) == i) >= k
                sampleA_mean = mean(distances_A(sorted_indices_A(1:k, j), j));
                sampleB_mean = mean(distances_B(sorted_indices_B(1:k, j), j));
                NN_boundary(i,j) = sampleA_mean < sampleB_mean;
            else
                NN_boundary(i,j) = distances_A(sorted_indices_A(1, j), j) < distances_B(sorted_indices_B(1, j), j);
            end
        end
    end
end

end
