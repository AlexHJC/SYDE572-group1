load("lab2_1.mat");
    
%estimated parameters for a
mean_a = mean(a);
std_a = std(a);
    
%true parameters for a
true_mean_a = 5;
true_std_a = 1;
    
%estimated parameters for b
mean_b = mean(b);
std_b = std(b);

%true parameters for b
lambda = 1;

%Gaussian case A 
Gauss1D(mean_a, std_a);
title('Gaussian ML Estimation, Case A');
Gauss1D(true_mean_a, true_std_a);
hold off;

%Gaussian case B
figure;
Gauss1D(mean_b, std_b);
title('Gaussian ML Estimation, Case B');
Exp1D(lambda);
hold off;

%Exponential case A
figure;
Exp1D(mean_a);
title('Exponential ML Estimation, Case A');
Gauss1D(true_mean_a, true_std_a);
hold off;

%Exponential case B
figure;
Exp1D(mean_b);
title('Exponential ML Estimation, Case B');
Exp1D(lambda);
hold off;

%Uniform case A
figure;

Gauss1D(true_mean_a, true_std_a);
title('Uniform ML Estimation, Case A');
hold off;

%Uniform case B
figure;

Exp1D(lambda);
title('Uniform ML Estimation, Case B');
hold off;


