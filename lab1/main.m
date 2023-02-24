% SYDE 572 Lab 1
% 02-27-2023
% Mohammed Abidi
% Alex Cho
% Etido Thompson
% Oceane Vandame 20728517

clear all
clc

%% Cluster generation

% Case 1
A_size = 200;
A_mean = [5, 10];
A_cov = [8 0; 0 4];

B_size = 200;
B_mean = [10, 15];
B_cov = [8 0; 0 4];

% Case 2
C_size = 100;
C_mean = [5, 10];
C_cov = [8 4; 4 40];

D_size = 200;
D_mean = [15, 10];
D_cov = [8 0; 0 8];

E_size = 150;
E_mean = [10, 5];
E_cov = [10 -5; -5 20];

% Create bivariate normal distributions for each class
class_A = bivariatenormalfunct(A_size, A_cov, A_mean);
class_B = bivariatenormalfunct(B_size, B_cov, B_mean);
class_C = bivariatenormalfunct(C_size, C_cov, C_mean);
class_D = bivariatenormalfunct(D_size, D_cov, D_mean);
class_E = bivariatenormalfunct(E_size, E_cov, E_mean);

%% Plotting samples

% Calculate required params for std dev contour
[thetaA, aA, bA] = std_contour(A_cov);
[thetaB, aB, bB] = std_contour(B_cov);
[thetaC, aC, bC] = std_contour(C_cov);
[thetaD, aD, bD] = std_contour(D_cov);
[thetaE, aE, bE] = std_contour(E_cov);

% Plotting case 1
figure(1)
hold on
title('Case 1: Class A & B')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

% Plotting case 2
figure(2)
hold on
title('Case 2: Class C, D & E')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

%% Classifiers

% Create mesh grid points

% Case 1
x1_vals_c1 = min([class_A(:,1);class_B(:,1)])-1 : 0.1 : max([class_B(:,1);class_B(:,1)])+1;
x2_vals_c1 = min([class_A(:,2);class_B(:,2)])-1 : 0.1 : max([class_B(:,2);class_B(:,2)])+1;
[X1_1, X2_1] = meshgrid(x1_vals_c1, x2_vals_c1);

% Case 2
x1_vals_c2 = min([class_C(:,1);class_D(:,1);class_E(:,1)])-1 : 0.1 : max([class_C(:,1);class_D(:,1);class_E(:,1)])+1;
x2_vals_c2 = min([class_C(:,2);class_D(:,2);class_E(:,2)])-1 : 0.1 : max([class_C(:,2);class_D(:,2);class_E(:,2)])+1;
[X1_2, X2_2] = meshgrid(x1_vals_c2, x2_vals_c2);

% Classify each point with MED 
% Create MED grid
med_grid = create_mesh_grid(X1_1, X2_1);
med_applied = MED_clf(med_grid, X1_1, X2_1, A_mean, B_mean);

%% Plotting Classifiers

% Case 1 -- MED, MICD & MAP Classifiers
figure(3)
hold on
title('Case 1: MED, MICD & MAP Classifiers')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')
contour(X1_1, X2_1, med_applied, DisplayName='MED decision boundary') % MED CLASSIFIER
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off 

% Case 1 -- NN & 5NN Classifiers
figure(4)
hold on
title('Case 1: NN & 5NN Classifiers')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

% Case 2 -- MED, MICD & MAP Classifiers
figure(5)
hold on
title('Case 2: MED, MICD & MAP Classifiers')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

% Case 2 -- NN & 5NN Classifiers
figure(6)
hold on
title('Case 2: NN & 5NN Classifiers')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off


a=1;



