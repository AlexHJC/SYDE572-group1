% Given data

% Case 1
A_size = 200;
A_mean = [5; 10];
A_cov = [8 0; 0 4];

B_size = 200;
B_mean = [10; 15];
B_cov = [8 0; 0 4];

% Case 2
C_size = 100;
C_mean = [5; 10];
C_cov = [8 4; 4 40];

D_size = 200;
D_mean = [15; 10];
D_cov = [8 0; 0 8];

E_size = 150;
E_mean = [10; 5];
E_cov = [10 -5; -5 20];

% Create bivariate normal distributions for each class
class_A = bivariatenormalfunct(A_size, A_cov, A_mean);
class_B = bivariatenormalfunct(B_size, B_cov, B_mean);
class_C = bivariatenormalfunct(C_size, C_cov, C_mean);
class_D = bivariatenormalfunct(D_size, D_cov, D_mean);
class_E = bivariatenormalfunct(E_size, E_cov, E_mean);

