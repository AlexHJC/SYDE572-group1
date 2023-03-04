%% K Nearest Neighbour Error Analysis

%%%%%% Class 1 %%%%%%%

% Confusion matrix
[TA, FA] = get_true_false(A_size, NN_clf_err(5, class_A_test, class_A, class_B), @(d) d < 0);
[TB, FB] = get_true_false(B_size, NN_clf_err(5, class_B_test, class_A, class_B), @(d) d > 0);

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

%%%%%% Class 2 %%%%%%%
% creating KNN classifications for all 9 combinations of each class
KNN_applied_cd_c = NN_clf_err(5, class_C_test, class_C, class_D);
KNN_applied_de_c = NN_clf_err(5, class_C_test, class_D, class_E);
KNN_applied_ec_c = NN_clf_err(5, class_C_test, class_E, class_C);

KNN_applied_cd_d = NN_clf_err(5, class_D_test, class_C, class_D);
KNN_applied_de_d = NN_clf_err(5, class_D_test, class_D, class_E);
KNN_applied_ec_d = NN_clf_err(5, class_D_test, class_E, class_C);

KNN_applied_cd_e = NN_clf_err(5, class_E_test, class_C, class_D);
KNN_applied_de_e = NN_clf_err(5, class_E_test, class_D, class_E);
KNN_applied_ec_e = NN_clf_err(5, class_E_test, class_E, class_C);

% Confusion matrix of the form:
%       Predicted:    C       D     E
% Actual:         C [ TC   TC_FD  TC_FE ]
%                 D [ TD_FC   TD  TD_FE ]
%                 E [ TE_FC TE_FD    TE ]

TC = 0;
TD = 0;
TE = 0;

FD_C = 0;
FE_C = 0;

FC_D = 0;
FE_D = 0;

FC_E = 0;
FD_E = 0;

for i = 1:length(class_C)
   class = classifypoint(KNN_applied_cd_c(i), KNN_applied_de_c(i), KNN_applied_ec_c(i));
   if class == 1
       TC = TC + 1;
   elseif class == 2
       FD_C = FD_C + 1;
   elseif class == 3
       FE_C = FE_C + 1;
   end
end

for i = 1:length(class_D)
   class = classifypoint(KNN_applied_cd_d(i), KNN_applied_de_d(i), KNN_applied_ec_d(i));
   if class == 1
       FC_D = FC_D + 1;
   elseif class == 2
       TD = TD + 1;
   elseif class == 3
       FE_D = FE_D + 1;
   end
end

for i = 1:length(class_E)
   class = classifypoint(KNN_applied_cd_e(i), KNN_applied_de_e(i), KNN_applied_ec_e(i));
   if class == 1
       FC_E = FC_E + 1;
   elseif class == 2
       FD_E = FD_E + 1;
   elseif class == 3
       TE = TE + 1;
   end
end

KNN_conf_matrix = [
    [TC, FD_C, FE_C];
    [FC_D, TD, FE_D];
    [FC_E, FD_E, TE];
];

disp('Confusion matrix for C, D & E:');
disp(KNN_conf_matrix);

correct_2 = (TC + TE + TD) / (C_size + D_size + E_size);
P_error_2 = 1 - correct_2;

disp('P(error) for C, D & E:');
disp(P_error_2);