function [applied_NN] = NEW_NN3_clf(grid, k, X1, X2, classA, classB, classC)
% Definition: For a given x you wish to classify, you compute the distance
% between x and all labeled samples, and you assign x the same class as its
% nearest neighbour

% initialize NNdist
applied_NN = grid;

A_distances = zeros(length(classA), 1);
B_distances = zeros(length(classB), 1);
C_distances = zeros(length(classC), 1);

% loop over every point in the grid
for i = 1:height(X1)
    for j = 1:width(X2)
        point = [X1(i,j), X2(i,j)];

        for l = 1:length(classA)
            A_distances(l) = sqrt((classA(l,1) - point(1))^2 + (classA(l,2) - point(2))^2);
        end
        A_sorted = sort(A_distances);
        A_essence = mean(A_sorted(1:k));

        for m = 1:length(classB)
            B_distances(m) = sqrt((classB(m,1) - point(1))^2 + (classB(m,2) - point(2))^2);
        end
        B_sorted = sort(B_distances);
        B_essence = mean(B_sorted(1:k));

        for n = 1:length(classC)
            C_distances(n) = sqrt((classC(n,1) - point(1))^2 + (classC(n,2) - point(2))^2);
        end
        C_sorted = sort(C_distances);
        C_essence = mean(C_sorted(1:k));

        essences = [A_essence, B_essence, C_essence];

        if (min(essences) == A_essence)
            applied_NN(i,j) = 1;
        elseif (min(essences) == B_essence)
            applied_NN(i,j) = 2;
        elseif (min(essences) == C_essence)
            applied_NN(i,j) = 3;
            end
        end
        
    end
end

