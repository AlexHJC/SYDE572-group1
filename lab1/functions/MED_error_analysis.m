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
% creating MED classifications for all 9 combinations of each class
MED_applied_cd_c = MED_clf_err(class_C, C_mean, D_mean);
MED_applied_de_c = MED_clf_err(class_C, D_mean, E_mean);
MED_applied_ec_c = MED_clf_err(class_C, E_mean, C_mean);

MED_applied_cd_d = MED_clf_err(class_D, C_mean, D_mean);
MED_applied_de_d = MED_clf_err(class_D, D_mean, E_mean);
MED_applied_ec_d = MED_clf_err(class_D, E_mean, C_mean);

MED_applied_cd_e = MED_clf_err(class_E, C_mean, D_mean);
MED_applied_de_e = MED_clf_err(class_E, D_mean, E_mean);
MED_applied_ec_e = MED_clf_err(class_E, E_mean, C_mean);

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
   class = classifypoint(MED_applied_cd_c(i), MED_applied_de_c(i), MED_applied_ec_c(i));
   if class == 1
       TC = TC + 1;
   elseif class == 2
       FD_C = FD_C + 1;
   elseif class == 3
       FE_C = FE_C + 1;
   end
end

for i = 1:length(class_D)
   class = classifypoint(MED_applied_cd_d(i), MED_applied_de_d(i), MED_applied_ec_d(i));
   if class == 1
       FC_D = FC_D + 1;
   elseif class == 2
       TD = TD + 1;
   elseif class == 3
       FE_D = FE_D + 1;
   end
end

for i = 1:length(class_E)
   class = classifypoint(MED_applied_cd_e(i), MED_applied_de_e(i), MED_applied_ec_e(i));
   if class == 1
       FC_E = FC_E + 1;
   elseif class == 2
       FD_E = FD_E + 1;
   elseif class == 3
       TE = TE + 1;
   end
end

MED3_conf_matrix = [
    [TC, FD_C, FE_C];
    [FC_D, TD, FE_D];
    [FC_E, FD_E, TE];
];

disp('Confusion matrix for C, D & E:');
disp(MED3_conf_matrix);

correct_2 = (TC + TE + TD) / (C_size + D_size + E_size);
P_error_2 = 1 - correct_2;

disp('P(error) for C, D & E:');
disp(P_error_2);