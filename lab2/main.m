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
clear 
clc

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
clear
clc

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

% system setup
clear;
close all;
load("lab2_3.mat");

% define grid
x_min = min([a(:,1); b(:,1)]);
x_max = max([a(:,1); b(:,1)]);
y_min = min([a(:,2); b(:,2)]);
y_max = max([a(:,2); b(:,2)]);
step = 1;
[x, y] = meshgrid(min(x_min, y_min):step:max(x_max, y_max));

% intitialize vars
J=5; % maximum number of sequential classifier attempts
limit = 10; % maximum number of discriminants made per classifier attempt
discriminant_list = zeros(J, limit, size(x,1), size(x,2)); % sequence of discriminants which are iterated through

sequence = ones(J,1); % working var to keep track of iterations
misclassified = zeros(J, limit); % working var to keep track of misclassified points

a_var = a;
b_var = b; % working vars of datasets a and b which are manipulated during runtime

misclassified_a = ones(J,1);
misclassified_b = ones(J,1); % working vars of number of misclassified points of b and a

for k=1:J
    while(misclassified_a(k) > 0 && misclassified_b(k) > 0 && sequence(k) <= J && sequence(k) <= limit && ~isempty(a_var) && ~isempty(b_var))
        rand_a = randi([1 length(a_var)]);
        rand_b = randi([1 length(b_var)]);
        mu_a = a(rand_a,:);
        mu_b = b(rand_b,:);

        discriminant = MED_clf(mu_a, mu_b, x, y);
        
        % Check for misclassified points
        misclassified_a(k) = 0;
        for i=1:length(a_var)
            if interp2(x,y,discriminant,a_var(i,1),a_var(i,2)) > 0
                misclassified_a(k) = misclassified_a(k) + 1;
            end
        end
        misclassified_b(k) = 0;
        for i=1:length(b_var)
            if interp2(x,y,discriminant,b_var(i,1),b_var(i,2)) > 0
                misclassified_b(k) = misclassified_b(k) + 1;
            end
        end

        % Store the total error for this sequence
        misclassified(k, sequence(k)) = misclassified_a(k) + misclassified_b(k);        
        sequence(k) = sequence(k) + 1;
        
        discriminant_list(k,sequence(k),:,:) = discriminant;
    end

    % no points in A that are misclassified as B, so remove correctly
    % classified points in B
    if (misclassified_a(k) == 0)
        b_var = b_var(interp2(x,y,discriminant,b_var(:,1),b_var(:,2)) < 0,:);
    end
    
    % no points in B that are misclassified as A, so remove correctly
    % classified points in A
    if (misclassified_b(k) == 0)
        a_var = a_var(interp2(x,y,discriminant,a_var(:,1),a_var(:,2)) > 0,:);
    end

end




