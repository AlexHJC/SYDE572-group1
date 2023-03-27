function Uniform1D(dataset)
   

    %plot 
    x_min = min(dataset);
    x_max = max(dataset);
    x = (x_min - 2):0.01:(x_max + 2);
    y1 = unifpdf(x, x_min, x_max);
    
    plot(x,y1);
    hold on;
    xlabel('x');
    ylabel('p(x)');
    grid on;






end