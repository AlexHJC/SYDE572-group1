function [ z ] = bivariatenormalfunct( n, sigma, mu)
    R = chol(sigma);
    z = repmat(mu,n,1) + randn(n,2)*R;
end
