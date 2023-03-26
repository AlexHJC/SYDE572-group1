function Gauss1D(mean, std)
    
    load("lab2_1.mat");
    
    %plot 
    x_min = min(a, b);
    x_max = max(a, b);
    x = x_min:0.01:x_max;
    y1 = normpdf(x, mean, std);
    
 
    plot(x,y1);
    hold on;
    xlabel('x');
    ylabel('p(x)');
    grid on;
    
    
end
   
    