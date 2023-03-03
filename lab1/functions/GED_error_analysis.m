%% GED Error analysis

% case 1

% populate two column vectors with the class A and B true positives (TA, TB) and the
% False positives (FA, FB)
[TA, FA] = get_true_false(A_size, GED_clf(ged_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov), @(d) d < 0);
[TB, FB] = get_true_false(B_size, GED_clf(ged_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov), @(d) d > 0);

% combine column vectors into 2x2 confusion matrix
GED_conf_matrix = [
    [TA, FB];
    [FA, TB];
];

% display confusion matrix in terminal
disp('Confusion matrix for Class A & B:');
disp(GED_conf_matrix);