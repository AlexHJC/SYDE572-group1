function [ T, F ] = get_true_false( sample_size, classifier, compare_func )
%get_true_false Compute the true and false points of the classifier.
% Returns the true predictions and the incorrect ones

T = 0;
for i=1:length(classifier)
    point = classifier(i);
    if compare_func(point)
        T = T + 1;
    end
end
F = sample_size - T;