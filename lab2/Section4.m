%% Section 4: Sequential discriminants

clear;
close all;
load('lab2_3.mat');

A_data4 = load('lab2_3','a');
B_data4 = load('lab2_3', 'b');
classA_part4 = A_data4.a;
classB_part4 = B_data4.b;

%% system set-up
x_min = min([a(:,1); b(:,1)]);
x_max = max([a(:,1); b(:,1)]);
y_min = min([a(:,2); b(:,2)]);
y_max = max([a(:,2); b(:,2)]);
step = 1;
[x, y] = meshgrid(x_min-2:step:x_max+2, y_min-1:step:y_max+2);
grid = zeros(size(x));

%% Compute Sequential Classifiers
% [4.1, 4.2]
[G1, err1] = sequential_classifier(x, y, 0, classA_part4, classB_part4);

%% sequential classifiers

% G1
figure;
scatter(classA_part4(:,1), classA_part4(:,2), 'ro');
hold on;
scatter(classB_part4(:,1), classB_part4(:,2), 'kx');
hold on;
contour(x,y,G1,'c');
title('Sequential Classifier 1');
legend('Class A','Class B', 'Sequential Classifier');
% legend({'Class A','Class B', 'Sequential Classifier'},'location' , 'southeast');
xlabel('x1');
ylabel('x2');
hold off;