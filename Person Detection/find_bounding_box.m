function [t, b, l, r] = find_bounding_box(frame_filename)

% frame_filename = 'frame0072.tif'

%getting frame number from image
[sequence_name, frame] = parse_frame_name(frame_filename);

%identifying previous and next image frame with 10 frames of diff.
prev_frame_name = make_frame_name(sequence_name, frame - 10);
next_frame_name = make_frame_name(sequence_name, frame + 10);

%reading in images
color_main_frame = imread(frame_filename);
color_prev_frame = imread(prev_frame_name);
color_next_frame = imread(next_frame_name);

%converting image data to double
double_main_frame = double(color_main_frame);
double_prev_frame = double(color_prev_frame);
double_next_frame = double(color_next_frame);

%converting images to grayscale
gray_main_frame = (double_main_frame(:,:,1) + double_main_frame(:,:,2) + double_main_frame(:,:,3))/3;
gray_prev_frame = (double_prev_frame(:,:,1) + double_prev_frame(:,:,2) + double_prev_frame(:,:,3))/3;
gray_next_frame = (double_next_frame(:,:,1) + double_next_frame(:,:,2) + double_next_frame(:,:,3))/3;

%calculating image differences
diff1 = abs(gray_main_frame - gray_prev_frame);
diff2 = abs(gray_main_frame - gray_next_frame);

%applying difference to motion
motion = min(diff1, diff2);

%setting a threshold for motion
threshold = 10;
thresholded = (motion > threshold);

% connected component analysis
[labels, number] = bwlabel(thresholded, 4);

% find the largest connected component
% create an array of counters, one for each connected component.
counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end
    
% find the id of the largest component (person)
[area, id] = max(counters);
person = (labels == id);
save_normalized(person, 'output/person.gif');

% finding the center of the person 
% find coordinates of all non-zero pixels.
[row_coords, col_coords] = find(person);
center_i = mean(row_coords);
center_j = mean(col_coords);
col_min = min(col_coords);
col_max = max(col_coords);
row_min = min(row_coords);
row_max = max(row_coords);

% make a copy
result_image = double_main_frame;

% round the top, bottom, left and right
t = round(row_min);
b = round(row_max);
l = round(col_min);
r = round(col_max);

%drawing rectangle on human
result_image = draw_rectangle(result_image, [255 255 0], t, b, l, r);

%displaying image with rectangle on human
figure;
imshow(result_image / 255);












