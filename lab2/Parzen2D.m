function pred = Parzen2D(pa, pb, pc, X, Y)

% classifiy each grid point by comparing associated probabilities
pred=zeros(size(X));

for i=1:height(X)
    for j=1:length(Y)
        [max_p, class] = max([pa(i,j), pb(i,j), pc(i,j)]);
        pred(i, j) = class;
    end
end

% plot results
contour(X, Y, pred, 'color', 'black');
hold on;
xlabel('x1');
ylabel('x2');

end 