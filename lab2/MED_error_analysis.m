function [ab_confusion_matrix, a_success, b_success] = MED_error_analysis(a_random_prototype,b_random_prototype,A_Class,B_Class)
% perform error analysis on the random prototype values, return the
% confusion matrix of a and b as well as the array of successful points
% classified in a and b
    
    naA = 0;     % True A (TA in lab 1)
    nbB = 0;     % True B (TB in lab 2)
    naB = 0;     % points in a misclassified as B (false B) (FB in lab 1)
    nbA = 0;     % points in b misclassified as A (false A) (FA in lab 1)
    a_success = double.empty;
    b_success = double.empty;

    % iterate through all points in A
    for i=1:size(A_Class, 1)
        k = A_Class(i,:);
        % assign every point in class A to k
        % if k is closer to a, then it is correctly classified as class A
        % else k is closer to b and it is misclassified as class B
        closer_to_A = MED_true_false(a_random_prototype, b_random_prototype, k);
        
        % record correct classification
        if closer_to_A
            naA = naA+1;
            a_success = vertcat(a_success, A_Class(i,:));
            
        % record misclassification
        else
            naB = naB + 1;
        end
    end

    % iterate through all points in B
    for i=1:size(B_Class, 1)
        k = B_Class(i,:);
        closer_to_A = MED_true_false(a_random_prototype, b_random_prototype, k);
        if closer_to_A
            nbA = nbA+1;
        else
            nbB = nbB + 1;
            b_success = vertcat(b_success, B_Class(i,:));
        end
    end

    % Confusion matrix of total true and false values
    ab_confusion_matrix = [
        [naA, naB];
        [nbA, nbB];
        ];

end
