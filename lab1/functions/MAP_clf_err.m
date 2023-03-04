function distance = MAP_clf_err(X1, mean1, mean2, cov1, cov2, prior1, prior2)

q0 = inv(cov1) - inv(cov2);
q1 = 2*mean2*inv(cov2) - 2*mean1*inv(cov1);
q2 = mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2';
q3 = log(prior2/prior1);
q4 = log(det(cov1)/det(cov2));

    distance = zeros(length(X1), 1);
    for i = 1:length(X1)
            xbar = X1(i,:);
            distance(i) = xbar*q0*xbar' + q1*xbar' + q2 + 2*q3 + q4;
    end