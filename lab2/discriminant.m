function [a_prototype, b_prototype, ab_confusion_matrix, a_success, b_success] = discriminant(a_data, b_data)
% function to calculate discriminant values in each iteration of the
% sequential classifier. only returns the correct discriminant which has 0
% misclassified points (naB == 0, nbA == 0)

continue_search = true;
% define loop condition, continue until adequate discriminant is found

    while continue_search
        % continue while confusion matrix contains misclassified points in
        % a OR b

        a_prototype = a_data(randi(size(a_data,1)),:);
        b_prototype = b_data(randi(size(b_data,1)),:);
        % select random point from a and b data

        [ab_confusion_matrix, a_success, b_success] = MED_error_analysis(a_prototype, b_prototype, a_data, b_data);
        % evaluate the confusion matrix and correctly identified points
        % using the random points. the goal is to find a discriminant which
        % correctly identifies at least 1 class exactly right.
        %   P(true class is C_i)|G says C_i) = 1 for at least 1 class

        % if confusion matrix contains misclassified points in both a and b
        % classes then recalculate discriminant with new random points
        if ab_confusion_matrix(1,2) == 0 || ab_confusion_matrix(2,1) == 0
            continue_search = false;
        end

    end

end
