function NNdist = NN_clf_err(k, X1, classA, classB)

    NNdist = zeros(length(X1), 1);
    
    for i=1:length(X1)
        xbar = X1(i, :);
        a_distances = sqrt(sum((classA - xbar).^2, 2));
        b_distances = sqrt(sum((classB - xbar).^2, 2));

        [~, sorted_a] = sort(a_distances);
        mean_a = mean(a_distances(sorted_a(1:k)));
        [~, sorted_b] = sort(b_distances);
        mean_b = mean(b_distances(sorted_b(1:k)));

        if mean_a > mean_b
            NNdist(i) = 1;
        else
            NNdist(i) = 0;
        end
    end
end