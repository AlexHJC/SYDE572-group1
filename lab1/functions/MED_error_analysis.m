%% MED Error Analysis

%%%%%% Case 1 %%%%%%%

% Confusion matrix
[TA, FA] = get_true_false(A_size, MED_clf_err(class_A, A_mean, B_mean), @(d) d < 0);
[TB, FB] = get_true_false(B_size, MED_clf_err(class_B, A_mean, B_mean), @(d) d > 0);

MED_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(MED_conf_matrix_ab);

P_error_1 = (FA + FB)/(A_size + B_size);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Case 2 %%%%%%%