function coordinates = detect_digit(image, template)

    result = normalized_correlation(image, template);
    result = result > 0.1;
%     figure(); imshow(result, []);

    %% connected component analysis
    [labels, number] = bwlabel(result, 4);
    % find the largest connected component
    % create an array of counters, one for each connected component.
    counters = zeros(1,number);
    for i = 1:number
        component_image = (labels == i);
        counters(i) = sum(component_image(:));
    end
    
    %% find the id of the largest component 
    [area, id] = max(counters);
    object = (labels == id);
    
    %% finding the center of the component 
    % find coordinates of all non-zero pixels.
    [row_coords, col_coords] = find(object);
    center_i = round(mean(row_coords));
    center_j = round(mean(col_coords));
    t = center_i - 14;
    b = center_i + 14;
    l = center_j - 14;
    r = center_j + 14;

    %%
    result_image = draw_rectangle1(image, t, b, l, r);
    figure(); imshow(result_image,[]);
    coordinates = [center_i center_j];
    
end