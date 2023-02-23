function [theta, a, b] = std_contour(sigma)
    [eigVec, eigVal] = eig(sigma);
    %theta = max(max(atan(eigVec(:,1)/eigVec(:,2))));
    theta = max(atan2(eigVec(:,1),eigVec(:,2)));
    %a = max(max(eigVal));
    %b = min(max(eigVal));
    a = eigVal(1,1);
    b = eigVal(2,2);
end


