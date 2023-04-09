function [min_error, max_error, avg_error, std_error] = SEQ_clf_err(x, y, a_data, b_data)
% calculate the minimum error rate, maximum error rate, average error rate,
% and std deviation of the error rates with varying maximum values of J
% from 1 to 5 with each classifier learned 20 times
    min_error = double.empty;
    max_error = double.empty;
    avg_error = double.empty;
    std_error = double.empty; 
        % initialize empty arrays to store the error for each J sequence

    for j=1:5
        error_list = double.empty;
            % initialize/reset error rate for each J sequence
        for i=1:20
            [G, error] = seq_classifier(x, y, j, a_data, b_data);
            error_list = vertcat(error_list, error);
                % calculate error and store into error list
        end
        min_error = vertcat(min_error, [j, min(error_list)]);
        max_error = vertcat(max_error, [j, max(error_list)]);
        avg_error = vertcat(avg_error, [j, mean(error_list)]);
        std_error = vertcat(std_error, [j, std(error_list)]);
            % calculate final values from error list and store which J
            % sequence the error was calculated from
    end

end