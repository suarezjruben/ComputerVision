function [result, start_frame, end_frame] = dtw2(sequence1, sequence2)
    v1 = sequence1;
    v2 = sequence2;

    [rows, cols] = size(v2);

    lowest = Inf;

    for i=1:cols-5
        for j=i+1:cols
            temp = dtw(v1, v2(:, i:j));
            if(temp < lowest)
                start_frame = i;
                end_frame = j;
                lowest = temp;
            end
        end
    end


    result = lowest;

end