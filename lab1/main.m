%% SYDE 572 Lab 1
% 02-27-2023
% Mohammed Abidi 20720554
% Alex Cho 20800781
% Etido Thompson 20765765
% Oceane Vandame 20728517


%% Clearing plots and setting global variables
close all;
clear vars;
clc;

% Set random state for consistency
rng(2);

% Adding functions folder
addpath('./functions')

% Setting linewidth and contour level
level = 10;
LINE_WIDTH = 4;

%% Cluster generation

% Case 1
A_size = 200;
A_mean = [5, 10];
A_cov = [8 0; 0 4];
A_prior = 200/400;

B_size = 200;
B_mean = [10, 15];
B_cov = [8 0; 0 4];
B_prior = 200/400;

% Case 2
C_size = 100;
C_mean = [5, 10];
C_cov = [8 4; 4 40];
C_prior = 300/450;

D_size = 200;
D_mean = [15, 10];
D_cov = [8 0; 0 8];
D_prior = 200/450;

E_size = 150;
E_mean = [10, 5];
E_cov = [10 -5; -5 20];
E_prior = 150/450;

% Create bivariate normal distributions for each class
class_A = bivariatenormalfunct(A_size, A_cov, A_mean);
class_B = bivariatenormalfunct(B_size, B_cov, B_mean);
class_C = bivariatenormalfunct(C_size, C_cov, C_mean);
class_D = bivariatenormalfunct(D_size, D_cov, D_mean);
class_E = bivariatenormalfunct(E_size, E_cov, E_mean);

%% Generating Clusters

% Calculate required params for std dev contour
[thetaA, aA, bA] = std_contour(A_cov);
[thetaB, aB, bB] = std_contour(B_cov);
[thetaC, aC, bC] = std_contour(C_cov);
[thetaD, aD, bD] = std_contour(D_cov);
[thetaE, aE, bE] = std_contour(E_cov);

% Plotting case 1
figure(1)
hold on
title('Generated clusters for Class A & B')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A', Marker='.')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B', Marker='.')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

% Plotting case 2
figure(2)
hold on
title('Generated clusters for Class C, D & E')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C', Marker='.')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D', Marker='.')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E', Marker='.')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')
xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

%% Create mesh grid points for classifiers
% Case 1
x1_vals_c1 = min([class_A(:,1);class_B(:,1)])-1 : 0.1 : max([class_B(:,1);class_B(:,1)])+1;
x2_vals_c1 = min([class_A(:,2);class_B(:,2)])-1 : 0.1 : max([class_B(:,2);class_B(:,2)])+1;
[X1_1, X2_1] = meshgrid(x1_vals_c1, x2_vals_c1);

% Case 2
x1_vals_c2 = min([class_C(:,1);class_D(:,1);class_E(:,1)])-1 : 0.1 : max([class_C(:,1);class_D(:,1);class_E(:,1)])+1;
x2_vals_c2 = min([class_C(:,2);class_D(:,2);class_E(:,2)])-1 : 0.1 : max([class_C(:,2);class_D(:,2);class_E(:,2)])+1;
[X1_2, X2_2] = meshgrid(x1_vals_c2, x2_vals_c2);

%% Classify data sets

% Case 1:

% Classify each point with MED 
med_grid = create_mesh_grid(X1_1, X2_1);
med_applied = MED_clf(med_grid, X1_1, X2_1, A_mean, B_mean);

% Classify each point with GED 
ged_grid = create_mesh_grid(X1_1, X2_1);
ged_applied = GED_clf(ged_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov);

% Classify each point with MAP
map_grid = create_mesh_grid(X1_1, X2_1);
map_applied = MAP_clf(map_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov, A_prior, B_prior);

% Classify each point with NN:
NN_grid = create_mesh_grid(X1_1, X2_1);
NN_applied = NN_clf(NN_grid, 1,X1_1, X2_1, class_A, class_B);

% Classify each point with kNN (k=5):
kNN_grid = create_mesh_grid(X1_1, X2_1);
kNN_applied = NN_clf(kNN_grid, 5, X1_1, X2_1, class_A, class_B);

% Case 2:

% Classify each point with MED 
med3_grid = create_mesh_grid(X1_2, X2_2);
med3_applied = MED3_clf(med3_grid, X1_2, X2_2, C_mean, D_mean, E_mean);

% Classify each point with GED 
ged3_grid = create_mesh_grid(X1_2, X2_2);
ged3_applied = GED3_clf(ged3_grid, X1_2, X2_2, C_mean, D_mean, E_mean, C_cov, D_cov, E_cov);

% Classify each point with MAP
map3_grid = create_mesh_grid(X1_2, X2_2);
map3_applied = MAP3_clf(map3_grid, X1_2, X2_2, C_mean, D_mean, E_mean, C_cov, D_cov, E_cov, C_prior, D_prior, E_prior);

% Classify each point with NN:
NN3_grid = create_mesh_grid(X1_2, X2_2);
NN3_applied = NN3_clf(NN3_grid, 1 ,X1_2, X2_2, class_A, class_B, class_C);

% Classify each point with kNN (k=5):
kNN3_grid = create_mesh_grid(X1_2, X2_2);
kNN3_applied = NN3_clf(kNN3_grid, 5, X1_2, X2_2, class_A, class_B, class_C);

%% Plotting Classifiers Case 1

% Case 1 -- MED, GED, MICD & MAP Classifiers
figure(3)
hold on
title('Case 1: MED, GED/MICD & MAP Classifiers')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A', Marker='.')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B', Marker='.')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')

% add decision boundaries for MED, GED/MICD, MAP classifiers
contour(X1_1, X2_1, med_applied, level, "black", DisplayName='MED decision boundary') % MED CLASSIFIER
contour(X1_1, X2_1, ged_applied, level, "green", DisplayName='GED decision boundary') % GED/MICD CLASSIFIER
contour(X1_1, X2_1, map_applied, level, "--blue", DisplayName='MAP decision boundary') % MAP CLASSIFIER

% % add shaded decision boundary regions
% contourf(X1_1, X2_1, med_applied, level, "black", DisplayName='MED decision boundary', FaceAlpha=0.25) % MED CLASSIFIER
% contourf(X1_1, X2_1, ged_applied, level, "green", DisplayName='GED decision boundary', FaceAlpha=0.25) % GED/MICD CLASSIFIER
% contourf(X1_1, X2_1, map_applied, level, "--blue", DisplayName='MAP decision boundary', FaceAlpha=0.25) % MAP CLASSIFIER

xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off 

%% Case 1 -- NN & 5NN Classifiers
figure(4)
hold on
title('Case 1: NN & 5NN Classifiers')
scatter(class_A(:,1), class_A(:,2), 'red', DisplayName='Class A', Marker='.')
scatter(class_B(:,1), class_B(:,2), 'blue', DisplayName='Class B', Marker='.')
plot_ellipse(A_mean(1), A_mean(2), thetaA, aA, bA, 'red', 'Std. dev contour for Class A')
plot_ellipse(B_mean(1), B_mean(2), thetaB, aB, bB, 'blue', 'Std. dev contour for Class B')

% add decision boundaries for NN, 5NN classifiers
contour(X1_1, X2_1, NN_applied, level, 'c', DisplayName='NN decision boundary') % NN CLASSIFIER
contour(X1_1, X2_1, kNN_applied, level, 'm', DisplayName='kNN decision boundary') % 5NN CLASSIFIER

% % add shaded decision boundary regions
% contourf(X1_1, X2_1, NN_applied, level, 'c', DisplayName='NN decision boundary', FaceAlpha=0.25) % NN CLASSIFIER
% contourf(X1_1, X2_1, kNN_applied, level, 'm', DisplayName='kNN decision boundary', FaceAlpha=0.25) % 5NN CLASSIFIER

xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

%% Plotting Classifiers Case 2
% Case 2 -- MED, GED, MICD & MAP Classifiers
figure(5)
hold on
title('Case 2: MED, GED/MICD & MAP Classifiers')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C', Marker='.')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D', Marker='.')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E', Marker='.')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')

% add decision boundaries for MED, GED/MICD, MAP classifiers
contour(X1_2, X2_2, med3_applied, level, "black", DisplayName='MED decision boundary') % MED CLASSIFIER
contour(X1_2, X2_2, ged3_applied, level, "green", DisplayName='GED decision boundary') % GED/MICD CLASSIFIER
contour(X1_2, X2_2, map3_applied, level, "--blue", DisplayName='MAP decision boundary') % MAP CLASSIFIER

% % add shaded decision boundary regions
% contourf(X1_2, X2_2, med3_applied, level, "black", DisplayName='MED decision boundary', FaceAlpha=0.25) % MED CLASSIFIER
% contourf(X1_2, X2_2, ged3_applied, level, "green", DisplayName='GED decision boundary', FaceAlpha=0.25) % GED/MICD CLASSIFIER
% contourf(X1_2, X2_2, map3_applied, level, "--blue", DisplayName='MAP decision boundary', FaceAlpha=0.25) % MAP CLASSIFIER

xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

%% Case 2 -- NN & 5NN Classifiers
% something wrong with the NN and KNN classifiers for case 2
% definitely not correct
figure(6)
hold on
title('Case 2: NN & 5NN Classifiers')
scatter(class_C(:,1), class_C(:,2), 'red', DisplayName='Class C', Marker='.')
scatter(class_D(:,1), class_D(:,2), 'blue', DisplayName='Class D', Marker='.')
scatter(class_E(:,1), class_E(:,2), 'green', DisplayName='Class E', Marker='.')
plot_ellipse(C_mean(1), C_mean(2), thetaC, aC, bC, 'red', 'Std. dev contour for Class C')
plot_ellipse(D_mean(1), D_mean(2), thetaD, aD, bD, 'blue', 'Std. dev contour for Class D')
plot_ellipse(E_mean(1), E_mean(2), thetaE, aE, bE, 'green', 'Std. dev contour for Class E')

% add decision boundaries for NN, 5NN classifiers
contour(X1_2, X2_2, NN3_applied, level, 'c', DisplayName='NN decision boundary') % NN CLASSIFIER
contour(X1_2, X2_2, kNN3_applied, level, 'm', DisplayName='kNN decision boundary') % 5NN CLASSIFIER

% % add shaded decision boundary regions
% contourf(X1_2, X2_2, NN3_applied, level, 'c', DisplayName='NN decision boundary', FaceAlpha=0.25) % NN CLASSIFIER
% contourf(X1_2, X2_2, kNN3_applied, level, 'm', DisplayName='kNN decision boundary', FaceAlpha=0.25) % 5NN CLASSIFIER

xlabel('x1')
ylabel('x2')
legend('Location', 'northeast')
hold off

%% error analysis
disp('MED Error analysis:');
MED_error_analysis;
disp('GED Error analysis:');
GED_error_analysis;
disp('MAP Error analysis:');
MAP_error_analysis;

% create new test variables for NN KNN testing
rng(6);
class_A_test = bivariatenormalfunct(A_size, A_cov, A_mean);
class_B_test = bivariatenormalfunct(B_size, B_cov, B_mean);
class_C_test = bivariatenormalfunct(C_size, C_cov, C_mean);
class_D_test = bivariatenormalfunct(D_size, D_cov, D_mean);
class_E_test = bivariatenormalfunct(E_size, E_cov, E_mean);

disp('NN Error analysis:');
NN_error_analysis;
disp('KNN Error analysis:');
KNN_error_analysis;

disp('---end of calculations---')

