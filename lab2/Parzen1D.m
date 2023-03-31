function Parzen1D(dataset, std)
    %std = 0.1
    
    % calculate sum of PDFs
    x_min = min(dataset);
    x_max = max(dataset);
    x = (x_min - 2):0.01:(x_max + 2);
    y1 = zeros(1, size(x,2));
    N = length(dataset);


    for i = 1:size(x,2)
        p = zeros(1,N); % reset
        for j = 1:N
            p(j) = normpdf(x(i), dataset(j), std);
        end
        y1(i) = sum(p)/N;
    end
    
    % plot
    plot(x,y1);
    hold on;
    xlabel('x');
    ylabel('p(x)');
    grid on;

end