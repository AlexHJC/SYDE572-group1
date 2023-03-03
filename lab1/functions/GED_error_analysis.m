%% GED Error analysis

% case 1

[TA, FA] = get_error(A_size, GED_clf(ged_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov), @(d) d < 0);
[TB, FB] = get_error(B_size, GED_clf(ged_grid, X1_1, X2_1, A_mean, B_mean, A_cov, B_cov), @(d) d > 0);

GED_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(GED_conf_matrix_ab);