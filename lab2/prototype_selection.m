function [prototypeA,prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA,classB)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    while true
        % 2. Randomly select one point from a and one point from b
        prototypeA = classA(randi(size(classA,1)),:);
        prototypeB = classB(randi(size(classB,1)),:);
        % 3-4 in MED_error_analysis
        [AB_confusion, success_A, success_B] = MED_error_analysis_fxn(prototypeA, prototypeB, classA, classB);
        % For a good sequential classifier, what we want are discriminants
        % that get some part of some class exactly right, so that
        % P(true class is C_i)|G says C_i) = 1 for @least 1 class
        % ^ Misclassified points = 0 for at least one class
        % 
        % 5. if naB, nbA =/= 0, go back to step 2 (loop)
        if (AB_confusion(1,2) == 0) || (AB_confusion(2,1) == 0)
            % else, discriminant is good (go to step 6, return to
            % sequential_classifier where this location this fxn was called
            break
        end
    end 
end
