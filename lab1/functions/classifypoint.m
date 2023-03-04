function [class] = classifypoint(cd,de,ce)

%     returns the class a point belongs to given the bivariate normal
%     distribution of three classes
c = 1; d = 2; e = 3;
    if (cd <= 0 && ce >= 0)
        class = c;
    elseif (cd >= 0 && de <= 0)
        class = d;
    elseif (de >= 0 && ce <= 0)
        class = e;
    end
end