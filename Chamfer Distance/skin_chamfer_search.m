
function [scores, result_image] = skin_chamfer_search(color_image, edge_image, template, scale, number_of_results)

positive_histogram = read_double_image('positives.bin');
negative_histogram = read_double_image('negatives.bin');

% Skin detection
skin = detect_skin(color_image, positive_histogram,  negative_histogram);

% conveting skin to binary
skin = skin * 100;
skin = skin > 80;

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

% Combining scores and skins
object_and_skin = skin + scores;

% connected component analysis
[labels, number] = bwlabel(object_and_skin, 4);

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

