%% SYDE 572 Lab 2
% 04-09-2023
% Mohammed Abidi 20720554
% Alex Cho 20800781
% Etido Thompson 20765765
% Oceane Vandame 20728517

%% SECTION 2: Model Estimation of the 1D Case

clear;
clc;
close all;
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
legend("Estimated p(x)","True p(x)");
hold off;

%Gaussian case B
figure;
Gauss1D(mean_b, std_b);
title('Gaussian ML Estimation, Case B');
Exp1D(lambda);
legend("Estimated p(x)","True p(x)");
hold off;

%Exponential case A
figure;
Exp1D(1/mean_a);
title('Exponential ML Estimation, Case A');
Gauss1D(true_mean_a, true_std_a);
legend("Estimated p(x)","True p(x)");
hold off;

%Exponential case B
figure;
Exp1D(1/mean_b);
title('Exponential ML Estimation, Case B');
Exp1D(lambda);
legend("Estimated p(x)","True p(x)");
hold off;

%Uniform case A
figure;
Uniform1D(a);
Gauss1D(true_mean_a, true_std_a);
title('Uniform ML Estimation, Case A');
legend("Estimated p(x)","True p(x)");
hold off;

%Uniform case B
figure;
Uniform1D(b);
Exp1D(lambda);
title('Uniform ML Estimation, Case B');
legend("Estimated p(x)","True p(x)");
hold off;

%Parzen case A 

% standard deviation = 0.1
std1 = 0.1;
figure;
Parzen1D(a, std1);
Gauss1D(true_mean_a, true_std_a); % True case A
title('Parzen Estimation, Case A, Std. Dev. = 0.1');
legend("Estimated p(x)(std dev = 0.1)","True p(x)");
hold off;

% standard deviation = 0.4
std2 = 0.4;
figure;
Parzen1D(a, std2);
Gauss1D(true_mean_a, true_std_a); % True case A
title('Parzen Estimation, Case A, Std. Dev. = 0.4');
legend("Estimated p(x) (std dev = 0.4)","True p(x)");
hold off;

%Parzen case B

% standard deviation = 0.1
figure;
Parzen1D(b, std1);
Exp1D(lambda); % True case B
title('Parzen Estimation, Case B, Std. Dev. = 0.1');
legend("Estimated p(x)(std dev = 0.1)","True p(x)");
hold off;

% standard deviation = 0.4
figure;
Parzen1D(b, std2);
Exp1D(lambda); % True case B
title('Parzen Estimation, Case B, Std. Dev. = 0.4');
legend("Estimated p(x) (std dev = 0.4)","True p(x)");
hold off;

%% SECTION 3: Model Estimation of the 2D Case
clear; 
clc;
close all;
load("lab2_2.mat");

% Parametric estimation

% Finding mean for the data set
mean_a = mean(al);
mean_b = mean(bl);
mean_c = mean(cl);
 
% Finding covariance for the data set
cov_a = cov(al);
cov_b = cov(bl);
cov_c = cov(cl);
 
% system set-up
x_min = min([al(:,1); bl(:,1); cl(:,1)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);
step = 1;
[x, y] = meshgrid(x_min-2:step:x_max+2, y_min-1:step:y_max+2);
grid = zeros(size(x));

% apply ML estimation & plot results
figure;
applied_ML_grid = ML2D(grid, x, y, mean_a, mean_b, mean_c, cov_a, cov_b, cov_c);
title('2D Parametric Estimation using Maximum Likelihood Estimation');
scatter(al(:,1), al(:,2))
scatter(bl(:,1), bl(:,2))
scatter(cl(:,1), cl(:,2))
legend("ML estimation boundary","class A", "class B", "class C");
hold off;

%% Non-parametric estimation

% system set-up
clear;
clc;
close all;
load("lab2_2.mat");

% system set-up
x_min = min([al(:,1); bl(:,1); cl(:,1)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);
step = 1;
[x, y] = meshgrid(min(x_min, y_min):step:max(x_max, y_max));
% needed for 2D pdf/parzen window
cov = eye(2)*400;
mu = [mean(x(1,:)), mean(y(:,1))];

% set up resolution and window to call parzen function
res = [step x_min y_min x_max y_max];
win = mvnpdf([x(:), y(:)], mu, cov);
win = reshape(win, size(x,1), size(y,2));

% calculate parzen probabilities
[pa, xa, ya] = parzen(al, res, win);
[pb, xb, yb] = parzen(bl, res, win);
[pc, xc, yc] = parzen(cl, res, win);

% mesh grid for final plot, same dimensions as parzen output for plot
[X, Y] = meshgrid(xa, ya);

% plot results
figure;
Parzen2D(pa, pb, pc, X, Y);
title('2D Non-parametric Estimation using Parzen Window');
scatter(al(:,1), al(:,2))
scatter(bl(:,1), bl(:,2))
scatter(cl(:,1), cl(:,2))
legend("Parzen window estimation boundary","class A", "class B", "class C");
hold off;

%% SECTION 4: Sequential Discriminants

clear;
clc;
close all;
load('lab2_3.mat');


a_data = a;
b_data = b;
A_Class = load('lab2_3','a');
B_Class = load('lab2_3', 'b');

%% system set-up
x_min = min([a(:,1); b(:,1)]);
x_max = max([a(:,1); b(:,1)]);
y_min = min([a(:,2); b(:,2)]);
y_max = max([a(:,2); b(:,2)]);
step = 1;
[x, y] = meshgrid(x_min-2:step:x_max+2, y_min-1:step:y_max+2);
grid = zeros(size(x));

%% Compute Sequential Classifiers
[G1, error1] = seq_classifier(x, y, 0, a_data, b_data);
[G2, error2] = seq_classifier(x, y, 0, a_data, b_data);
[G3, error3] = seq_classifier(x, y, 0, a_data, b_data);

%% Sequential Classifiers
% section 4.1
% G1
figure;
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G1,'b');
xlabel('x1');
ylabel('x2');
hold on;

% G2
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G2,'c');
xlabel('x1');
ylabel('x2');
hold on;

% G3
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G3,'g');
title('3 Sequential Classifiers');
legend('Class A','Class B');
xlabel('x1');
ylabel('x2');
hold off;

%% Probability Of Error
% section 4.2
disp("---probability of error for sequential classifiers---")
disp("error for sequential classifier 1 is = " + error1);
disp("error for sequential classifier 2 is = " + error2);
disp("error for sequential classifier 3 is = " + error3);

%% Calculate error rate with varying J
% section 4.3
[min, max, avg, std] = SEQ_clf_err(x, y, a_data, b_data);

%% Creating a plot to show error rate as a function of j
figure;
plot(min(:,2));
hold on;
plot(max(:,2));
hold on;
plot(avg(:,2));
hold on;
plot(std(:,2));
hold on;
xlim([1 5])
title('minimum error rate');
legend('Minimum Error Rate','Maximum Error Rate', 'Average Error Rate', 'Standard Deviation of the Error Rates');
xlabel('J');
ylabel('Error Rate');
hold off;