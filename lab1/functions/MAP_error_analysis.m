%% MAP Error analysis

%%%%%% Case 1 %%%%%%%

% populate two column vectors with the class A and B true positives (TA, TB) and the
% False positives (FA, FB)
[TA, FA] = get_true_false(A_size, MAP_clf_err(class_A, A_mean, B_mean, A_cov, B_cov, A_prior, B_prior), @(d) d < 0);
[TB, FB] = get_true_false(B_size, MAP_clf_err(class_B, A_mean, B_mean, A_cov, B_cov, A_prior, B_prior), @(d) d > 0);

% combine column vectors into 2x2 confusion matrix
GED_conf_matrix = [
    [TA, FB];
    [FA, TB];
];

% display confusion matrix in terminal
disp('Confusion matrix for Class A & B:');
disp(GED_conf_matrix)

P_error_1 = (FA + FB)/(A_size + B_size);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Case 2 %%%%%%%