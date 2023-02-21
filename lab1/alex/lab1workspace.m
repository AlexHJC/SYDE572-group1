% data
% case 1
A_size = 200;
A_mean = [5, 10];
A_cov = [8 0; 0 4];

B_size = 200;
B_mean = [10; 15];
B_cov = [8 0; 0 4];

% case 2
C_size = 100;
C_mean = [5; 10];
C_cov = [8 4; 4 40];

D_size = 200;
D_mean = [15; 10];
D_cov = [8 0; 0 8];

E_size = 150;
E_mean = [10; 5];
E_cov = [10 -5; -5 20];

% randn cluster generation
% R_A = chol(A_cov);
% A_dist = repmat(A_mean,10,1) + randn(A_size,1)*R_A

samples_a = bivariatenormalfunct(A_size, A_cov, A_mean);

plot(samples_a);


