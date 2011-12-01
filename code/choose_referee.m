function [referee] = choose_referee(max_id, exclude_id)
    referee = zeros(1, 2);
    referee(1) = randi(max_id, 1);
    while (referee(1) == exclude_id)
        referee(1) = randi(max_id, 1);
    end
    referee(2) = randi(max_id, 1);
    while (referee(2) == exclude_id || referee(2) == referee(1))
        referee(2) = randi(max_id, 1);
    end
end
