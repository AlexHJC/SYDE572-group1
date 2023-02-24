function [theta, a, b] = std_contour(sigma)
    [eigVec, eigVal] = eig(sigma);
    %theta = max(max(atan(eigVec(:,1)/eigVec(:,2))));
    if eigVal(1,1) > eigVal(2,2)
        theta = atan(eigVal(2,1)/eigVal(1,1));
        a = eigVal(1,1);
        b = eigVal(2,2);
    else
        theta = atan(eigVal(2,2)/eigVal(1,2));
        a = eigVal(2,2);
        b = eigVal(1,1);
        
    %theta = max(atan2(eigVec(:,1),eigVec(:,2)));
    %a = max(max(eigVal));
    %b = min(max(eigVal));
    %(1,1);
    %b = eigVal(2,2);
    end
end


