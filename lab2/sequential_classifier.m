function [G,err] = sequential_classifier(X,Y, j_lim, A_data, B_data)
    A_data_OG = A_data;
    B_data_OG = B_data;
    nA = 0;
    nB = 0;
    naB_nbA = int16.empty;
    a_prototypes = double.empty(0,2);
    b_prototypes = double.empty(0,2);
    j = 0;
    % j = 0 means no limit
    % In the above development we did not limit the # of seq classifiers
    
    while true
        [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(A_data, B_data);
        % 6. This discriminant is good; save it as disc fxn
        
        j = j+1;
        a_prototypes = vertcat(a_prototypes, prototypeA);
        b_prototypes = vertcat(b_prototypes, prototypeB);

        naB = AB_confusion(1,2); % #times G classifies a point from a as class B
        nbA = AB_confusion(2,1); % #times G classifies a point from b as class A
        naB_nbA = vertcat(naB_nbA, [naB, nbA]);
        
        % 7.
        if naB == 0 
            % then remove those points from b that G classifies as B
            B_data = setxor(B_data, success_B,'rows');
            % setxor
        end
        
        % 8.
        if nbA == 0 
            % then remove those points from a (A_data) that G
            % classifies as A (success_A) using 'set exclusive'
            A_data = setxor(A_data, success_A,'rows');
        end 
        
        if size(A_data,1)== 0 || size(B_data, 1) == 0
            break
        end
        
        if j_lim ~= 0 && j == j_lim
            break
        end
    end
    
    %% now have a sequence of discriminants
    % generate combinational sequential classifier  
    G = zeros(size(X));
    for k=1:numel(G)
        for i=1:j
            classified_A = MED_dis_bool(a_prototypes(i,:), b_prototypes(i,:), [X(k) Y(k)]);
            % classified as A && nbA = 0
            if classified_A && naB_nbA(i,2)== 0 
                G(k) = 10; % classify as A
                break
            % classified as B &D naB = 0
            elseif ~classified_A && naB_nbA(i,1)== 0 
                G(k) = 1; % classify as B
                break
            end
        end
    end
    
    %% error rate calculations
    % copy-paste from MED_error_analysis_fxn w/ slight changes
    for k=1:size(A_data_OG,1) 
        x_bar = A_data_OG(k,:); % some given point
        for i=1:j
            classified_A = MED_dis_bool(a_prototypes(i,:), b_prototypes(i,:), x_bar);
            % 3. If G_j classifies x_bar as class A and nbA,j = 0, say class A
            if classified_A
                nA = nA + 1;
                break
            end
            % otherwise, go back to step 3
        end  
    end
    for k=1:size(B_data_OG,1) 
        x_bar = B_data_OG(k,:);
        for i=1:j
            classified_A = MED_dis_bool(a_prototypes(i,:), b_prototypes(i,:), x_bar);
            % 2. If G_j classifies x_bar as class B and naB,j = 0, say class B
            if ~classified_A
                nB = nB + 1;
                break
            end
            % otherwise, go back to step 2
        end  
    end
    err = 1-((nA+nB)/400);
end

