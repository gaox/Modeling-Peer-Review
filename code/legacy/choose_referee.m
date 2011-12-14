function [referee] = choose_referee(author_accept, num_author_accept, max_id, exclude_id)
    referee = zeros(1, 2);
    if (num_author_accept == 2)
        if (author_accept(1) == exclude_id)
            referee(1) = author_accept(2);
            referee(2) = randi(max_id, 1);
            while (referee(2) == exclude_id || referee(2) == referee(1))
                referee(2) = randi(max_id, 1);
            end
        else
            referee(1) = author_accept(1);
            if (author_accept(2) == exclude_id)
                referee(2) = randi(max_id, 1);
                while (referee(2) == exclude_id || referee(2) == referee(1))
                    referee(2) = randi(max_id, 1);
                end
            else
                referee(2) = author_accept(2);
            end
        end
    elseif (num_author_accept == 1)
        if (author_accept(1) == exclude_id)
            referee(1) = randi(max_id, 1);
            while (referee(1) == exclude_id)
                referee(1) = randi(max_id, 1);
            end
            referee(2) = randi(max_id, 1);
            while (referee(2) == exclude_id || referee(2) == referee(1))
                referee(2) = randi(max_id, 1);
            end
        else
            referee(1) = author_accept(1);
            referee(2) = randi(max_id, 1);
            while (referee(2) == exclude_id || referee(2) == referee(1))
                referee(2) = randi(max_id, 1);
            end
        end
    elseif (isempty(author_accept))
        referee(1) = randi(max_id, 1);
        while (referee(1) == exclude_id)
            referee(1) = randi(max_id, 1);
        end
        referee(2) = randi(max_id, 1);
        while (referee(2) == exclude_id || referee(2) == referee(1))
            referee(2) = randi(max_id, 1);
        end
    else
        referee(1) = author_accept(randi(num_author_accept, 1));
        while (referee(1) == exclude_id)
            referee(1) = author_accept(randi(num_author_accept, 1));
        end
        referee(2) = author_accept(randi(num_author_accept, 1));
        while (referee(2) == exclude_id || referee(2) == referee(1))
            referee(2) = author_accept(randi(num_author_accept, 1));
        end
    end
end
