function [G, Error] = seq_classifier(x, y, limit, A, B)
%% sequential classifier
% x, y = grid values
% limit = maximum number of sequential classifier attempts
%           if limit == 0, then no limit to total attempts
% A, B = original a, b data
    a_data = A; % 200x2 double of given a data, manipulated during runtime
    b_data = B; % 200x2 double of given b data, manipulated during runtime
    naB = 0;    % points in a misclassified as class B
    nbA = 0;    % points in b misclassified as class A
    naA = 0;    % points in a correctly classified as class A
    nbB = 0;    % points in b correctly classified as class B
    j = 0;      % initialize count of sequences
    misclassified_points = double.empty; % empty array to store all misclassified points
    a_prototype_list = double.empty;    
    b_prototype_list = double.empty;    % empty array to hold list of adequate protypes
    continue_loop = true; % define loop condition, continue until adequate discriminant is found

    while continue_loop
        [a_prototype, b_prototype, ab_confusion_matrix, a_success, b_success] = discriminant(a_data, b_data);
        % working prototype saved in each iteration
        % saves the prototype a and b point used, the confusion matrix of
        % correctly classified and misclassified points in a and b, and an
        % array of the successfully classified points in a and b

        j = j+1;    % iterate j count and save the discriminant values from discriminant function

        a_prototype_list = vertcat(a_prototype_list, a_prototype);
        b_prototype_list = vertcat(b_prototype_list, b_prototype);

        naB = ab_confusion_matrix(1,2); % points in a classified as b from current discriminant
        nbA = ab_confusion_matrix(2,1); % points in b classified as a from current discriminant
        misclassified_points = vertcat(misclassified_points, [naB, nbA]);


        % if there are no misclassified b points
        % all points in a_data which were correctly classified as
        % class a from the current discriminant are removed
        if nbA == 0 
            a_data = setxor(a_data, a_success,'rows');
        end

        % if there are no misclassified a points
        % all points in b_data which were correctly classified as
        % class b from the current discriminant are removed
        if naB == 0 
            b_data = setxor(b_data, b_success,'rows');
        end

        % if all points in a or b has a prototype which can correctly 
        % classify it, then stop the loop
        if size(a_data,1)== 0 || size(b_data, 1) == 0
            continue_loop = false;
        end

        % if the limit is not 0, and j is greater than the limit then stop 
        % the loop 
        if limit == not(0) && j > limit
            continue_loop = false;
        end

    end

    %% create overall classifier
    % initialize sequential classifier G which is an array the size of the
    % given grid space
    % for every point in G, iterate through all the
    % discriminants and determine which prototype makes the correct
    % classification (nbA == 0, naB == 0). then assign the appropriate
    % classification at that point in G.
    G = zeros(size(x));
    for k=1:numel(G)
        for i=1:j
            closer_to_A = MED_true_false(a_prototype_list(i,:), b_prototype_list(i,:), [x(k) y(k)]);
            % classified as Class A && nbA == 0
            if closer_to_A && misclassified_points(i,2)== 0 
                G(k) = 10; % classify as A
                break
            % classified as Class B & naB == 0
            elseif ~closer_to_A && misclassified_points(i,1)== 0 
                G(k) = 1; % classify as B
                break
            end
        end
    end

    %% error analysis for each sequence
    % iterate through every point in class A, then determine how many
    % points were correctly classified by each sequence
    for k=1:size(A,1) 
        point = A(k,:);
        for i=1:j
            closer_to_A = MED_true_false(a_prototype_list(i,:), b_prototype_list(i,:), point);
                % determine if the point is correctly classified as A by 
                % prototype i, if true then add to number of correctly
                % classified points
            if closer_to_A
                naA = naA + 1;
                break
            end
        end  
    end
    for k=1:size(B,1) 
        point = B(k,:);
        for i=1:j
            closer_to_A = MED_true_false(a_prototype_list(i,:), b_prototype_list(i,:), point);
                % determine if the point is correctly classified as B by 
                % prototype i, if true then add to number of correctly
                % classified points
            if not(closer_to_A)
                nbB = nbB + 1;
                break
            end
        end  
    end

    Error = 1-( (naA+nbB) / (size(A,1) + size(B,1)) );

end
