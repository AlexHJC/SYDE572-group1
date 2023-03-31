%% SECTION 2: Model Estimation of the 1D Case

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
Exp1D(1/mean_a);
title('Exponential ML Estimation, Case A');
Gauss1D(true_mean_a, true_std_a);
hold off;

%Exponential case B
figure;
Exp1D(1/mean_b);
title('Exponential ML Estimation, Case B');
Exp1D(lambda);
hold off;

%Uniform case A
figure;
Uniform1D(a);
Gauss1D(true_mean_a, true_std_a);
title('Uniform ML Estimation, Case A');
hold off;

%Uniform case B
figure;
Uniform1D(b);
Exp1D(lambda);
title('Uniform ML Estimation, Case B');
hold off;

%Parzen case A 

% standard deviation = 0.1
std1 = 0.1;
figure;
Parzen1D(a, std1);
Gauss1D(true_mean_a, true_std_a); % True case A
title('Parzen Estimation, Case A, Std. Dev. = 0.1');
hold off;

% standard deviation = 0.4
std2 = 0.4;
figure;
Parzen1D(a, std2);
Gauss1D(true_mean_a, true_std_a); % True case A
title('Parzen Estimation, Case A, Std. Dev. = 0.4');
hold off;

%Parzen case B

% standard deviation = 0.1
figure;
Parzen1D(b, std1);
Exp1D(lambda); % True case B
title('Parzen Estimation, Case B, Std. Dev. = 0.1');
hold off;

% standard deviation = 0.4
figure;
Parzen1D(b, std2);
Exp1D(lambda); % True case B
title('Parzen Estimation, Case B, Std. Dev. = 0.4');
hold off;

%% SECTION 3: Model Estimation of the 2D Case

load("lab2_2.mat");

% Parametric estimation

% Non-parametric estimation
var2D = 400;



