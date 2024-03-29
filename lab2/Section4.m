%% Section 4: Sequential discriminants

clear;
clc;
close all;
load('lab2_3.mat');


a_data = a;
b_data = b;
A_Class = load('lab2_3','a');
B_Class = load('lab2_3', 'b');

%% system set-up
x_min = min([a(:,1); b(:,1)]);
x_max = max([a(:,1); b(:,1)]);
y_min = min([a(:,2); b(:,2)]);
y_max = max([a(:,2); b(:,2)]);
step = 1;
[x, y] = meshgrid(x_min-2:step:x_max+2, y_min-1:step:y_max+2);
grid = zeros(size(x));

%% Compute Sequential Classifiers
[G1, error1] = seq_classifier(x, y, 0, a_data, b_data);
[G2, error2] = seq_classifier(x, y, 0, a_data, b_data);
[G3, error3] = seq_classifier(x, y, 0, a_data, b_data);

%% Sequential Classifiers
% section 4.1
% G1
figure;
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G1,'c');
title('Sequential Classifier 1');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x1');
ylabel('x2');
hold off;

% G2
figure;
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G2,'c');
title('Sequential Classifier 2');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x1');
ylabel('x2');
hold off;

% G3
figure;
scatter(a_data(:,1), a_data(:,2), 'ro');
hold on;
scatter(b_data(:,1), b_data(:,2), 'kx');
hold on;
contour(x,y,G3,'c');
title('Sequential Classifier 3');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x1');
ylabel('x2');
hold off;

%% Probability Of Error
% section 4.2
disp("---probability of error---")
disp("error for sequential classifier 1 is " + error1);
disp("error for sequential classifier 2 is " + error2);
disp("error for sequential classifier 3 is " + error3);


%% Calculate error rate with varying J
% section 4.3
[min, max, avg, std] = SEQ_clf_err(x, y, a_data, b_data);
%% Creating a plot to show error rate as a function of j
figure;
plot(min(:,2));
hold on;
plot(max(:,2));
hold on;
plot(avg(:,2));
hold on;
plot(std(:,2));
hold on;
xlim([1 5])
ylim([0 0.26])
title('minimum error rate');
legend('Minimum Error Rate','Maximum Error Rate', 'Average Error Rate', 'Standard Deviation of the Error Rates');
xlabel('J');
ylabel('Error Rate');
hold off;