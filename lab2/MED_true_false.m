function [closer_to_A] = MED_true_false(a_random_prototype, b_random_prototype, k)
% calculate whether the select point from class k is closer to the random 
% prototype point from A than the random prototype point from B.
% if point k is closer to A than B then return true, otherwise, false.

    distance_to_A = sqrt((a_random_prototype(1)-k(1)).^2 + (a_random_prototype(2)-k(2)).^2);
    distance_to_B = sqrt((b_random_prototype(1)-k(1)).^2 + (b_random_prototype(2)-k(2)).^2);
    if distance_to_A < distance_to_B
        closer_to_A = true;
    else
        closer_to_A = false;
    end
end