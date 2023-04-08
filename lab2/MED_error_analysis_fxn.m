function [confusion_matrix,success_A,success_B] = MED_error_analysis_fxn(prototypeA,prototypeB,classA,classB)
%MED_error_analysis_fxn: Calcualte confusion matrix for MED + keep track of successfuly
%classified points from class A and class B
%   MED_error_analysis from Lab 1 submission but turned into a fxn because
%   misclassified points is a criterea in the loop as detailed in step 5
%   of Lab2-section4. We also want to keep track of class A datapoints that
%   have been successifully classified so that we can focus on the
%   datapoints that aren't correctly classified. Therefore, this function
%   will be a modified version of lab 1 that keeps track of more data;
%   thus, it will be longer and more complicated

    % Var names slightly changed from lab 1 to match wording of lab 2
    nA = 0;     % True A (TA in lab 1)
    nB = 0;     % True B (TB in lab 2)
    naB = 0;    % # of A misclassified as B (false B) (FB in lab 1)
                % LAB2: of times G classifies a point from a as class B
    nbA = 0;    % # of B misclassified as A (false A) (FA in lab 1)
                % LAB2: of times G classifies a point from b as class A
    
    % init 2 by n array (choosing ngrid instead of meshgrid
    % earlier on makes this easier)
    success_A = double.empty(0,2);
    success_B = double.empty(0,2);
    
    % iterate through class A
    for i=1:size(classA, 1)
        x = classA(i,:);
        % modified MED to return bool
        % 3. Create a discriminant G using MED w/ the 2 pts as prototypes
        AcloserB = MED_dis_bool(prototypeA, prototypeB, x);
        
        % if the dist to A < dist to B, the point was correctly classified
        if AcloserB
            nA = nA+1;
            success_A = vertcat(success_A, classA(i,:));
            
        % else, the point from class A classified as B (naB)
        else
            naB = naB + 1;
        end
    end
    
    % Repeat with class B
    for i=1:size(classB, 1)
        x = classB(i,:);
        AcloserB = MED_dis_bool(prototypeA, prototypeB, x);
        if AcloserB
            nbA = nbA+1;
        else
            nB = nB + 1;
            success_B = vertcat(success_B, classB(i,:));
        end
    end
    
    % 4. Using all of the data in a and b, work out the confusion matrix entries
    confusion_matrix = [
        nA    naB;
        nbA      nB;
        ];
end

