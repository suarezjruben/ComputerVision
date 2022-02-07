
function [scores, result_image] = chamfer_search(edge_image, template, scale, number_of_results)

result_image = edge_image;

[rows, cols] = size(template);
resized_template = imresize(template, scale, 'bilinear');

% converting to binary
resized_template = resized_template > 0;

% compute distance transform of edge image.
distance = bwdist(edge_image);

% compute image of chamfer distance scores 
result = imfilter(distance, double(resized_template), 'symmetric');

% normalize result, to make scores between 0 and 1.
result = result / max(max(result));
scores = result < .06;

% connected component analysis
[labels, number] = bwlabel(scores, 4);

% find the largest connected component
% create an array of counters, one for each connected component.
counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end

% find the ids of the largest 'number_of_results' components 
[area, id] = maxk(counters,10);

for i = 1:(number_of_results)
    object = (labels == id(i));

    % finding the center of the component 
    % find coordinates of all non-zero pixels.
    [row_coords, col_coords] = find(object);
    center_i = mean(row_coords);
    center_j = mean(col_coords);
    col_min = center_j - cols/2;
    col_max = center_j + cols/2;
    row_min = center_i - rows/2;
    row_max = center_i + rows/2;

    % round the top, bottom, left and right
    t = round(row_min);
    b = round(row_max);
    l = round(col_min);
    r = round(col_max);

    result_image = draw_rectangle1(result_image, t, b, l, r);
end

end

