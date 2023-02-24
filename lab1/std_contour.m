function [theta, a, b] = std_contour(sigma)
    [eigVec, eigVal] = eig(sigma);

    if eigVal(1,1) > eigVal(2,2)
        theta = atan(eigVec(2,1)/eigVec(1,1));
        a = eigVal(1,1);
        b = eigVal(2,2);
    else
        theta = atan(eigVec(2,2)/eigVec(1,2));
        a = eigVal(2,2);
        b = eigVal(1,1);
        
    end
end


