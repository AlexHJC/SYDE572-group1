function [class] = classifypoint(cd,de,ec)

%     returns the class a point belongs to given the bivariate normal
%     distribution of three classes
c = 1; d = 2; e = 3;
    if (cd <= 0 && ec >= 0)
        class = c;
%         fprintf('assigned class c\n')
    elseif (cd >= 0 && de <= 0)
        class = d;
%         fprintf('assigned class d\n')
    elseif (de >= 0 && ec <= 0)
        class = e;
%         fprintf('assigned class e\n')
    else
        %error condition
%         disp('error in classifying points')
        class = 0;
    end
end