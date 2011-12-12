function [editors] = assign_editor(num_scientist, num_journal)
    editors = zeros(1, num_journal);
    scientists = 1:num_scientist;
    max_index = scientists;
    for i = 1:num_journal
        j = randi(max_index, 1);
        editors(i) = j;
        scientists(j) = scientists(max_index);
        max_index = max_index - 1;
    end
end
