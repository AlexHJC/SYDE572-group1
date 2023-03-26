function Exp1D(lambda)
    
    load("lab2_1.mat");
    
    %true parameter
    lambda_b = 1;

    %plot 
    x_min = min(a, b);
    x_max = max(a, b);
    x = x_min:0.01:x_max;
    y1 = exppdf(x, lambda);
    
    plot(x,y1);
    hold on;
    xlabel('x');
    ylabel('p(x)');
    grid on;