function [classified_as_A] = MED_dis_bool(prototypeA, prototypeB, x)
% Modified MED_dis from lab 1 to...
%   - return a bool instead  
%   - instead of having a for loop in main + here, the for loops is just in MED_error_analysis
% SUMMARY: Calculate dist b/w prototypeA and B, return classification bool
    dist_classA = sqrt((prototypeA(1)-x(1)).^2 + (prototypeA(2)-x(2)).^2);
    dist_classB = sqrt((prototypeB(1)-x(1)).^2 + (prototypeB(2)-x(2)).^2);
    if dist_classA < dist_classB
        classified_as_A = true;
    else
        classified_as_A = false;
    end
end

