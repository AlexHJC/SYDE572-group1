%% NN Error Analysis

%%%%%% Case 1 %%%%%%%

% Confusion matrix
[TA, FA] = get_true_false(A_size, NN_clf_err(1, class_A, class_B, class_A_test), @(d) d < 0);
[TB, FB] = get_true_false(B_size, NN_clf_err(1, class_A, class_B, class_B_test), @(d) d > 0);

% P(error)
P_error_1 = (FA + FB) / (A_size + B_size);

NN_conf_matrix_ab = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for A & B:');
disp(NN_conf_matrix_ab);

disp('P_error for A & B:');
disp(P_error_1);

%%%%%% Case 2 %%%%%%%