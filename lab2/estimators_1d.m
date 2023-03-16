%% SYDE 572 Lab 2
% 03-10-2023
% Mohammed Abidi 20720554
% Alex Cho 20800781
% Etido Thompson 20765765
% Oceane Vandame 20728517

%% Clearing plots and setting global variables
close all;
clear vars;
clc;

%% 1-D Gaussian Model Estimation
%code
function Gauss1D(mean_a, std_a, true_mean_a, true_std_a)
    
    %plot 
    x_min = min(a, b);
    x_max = max(a, b);
    x = x_min:0.01:x_max;
    y1 = normpdf(x, mean_a, std_a);
    y2 = normpdf(x, true_mean_a, true_std_a);
    y3 = normpdf(x, mean_b, std_b);
    
    plot(x,y1);
    hold on;
    plot(x,y2);
    hold off;
    title('skrrt');
    xlabel('x');
    ylabel('p(x)');
    grid on;
    
    figure;plot(x,y3);
    hold on;
    title('skrrt');
    xlabel('x');
    ylabel('p(x)');
    grid on;
    
end
   
    

%% 1-D Exponential Model Estimation
%code
%given parameter
function Exp1D()

    load("lab2_1.mat");
    
    
    %true parameter
    lambda_b = 1;

    
    %plot 
    x_min = min(a, b);
    x_max = max(a, b);
    x = x_min:0.01:x_max;
    y1 = exppdf(x, lambda);
   
    
    plot(x,y1);
    hold on
    plot(x,y2);
    hold off;
    title('skrrt');
    xlabel('x');
    ylabel('p(x)');
    grid on;
    
    figure;plot(x,y3);
    hold on;
    title('skrrt');
    xlabel('x');
    ylabel('p(x)');
    grid on;
    
end


%% 1-D Uniform Model Estimation

%code

%% 1-D Non-Parametric Model Estimation

%code