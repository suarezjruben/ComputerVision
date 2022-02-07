function [result, boxes] = cnn_detector_demo(image, scales, model, face_size, result_number)



% face_size = [31, 25];
% result_number = 2;

boxes = zeros(result_number, 6);
% [image_rows, image_columns] = size(image); %kid face
load filter.mat

% image = double(imread('vjm.bmp'));
[image_rows, image_columns] = size(image);
% figure;imshow(image, []);                                       %scales
[corr_result, scales] = multiscale_correlation(image, face_filter, scales);
% figure();imshow(corr_result, []);
% figure(2); imshow(corr_result > 0.5, []);

% 
% visualization = max((corr_result > 0.5)*255, image);
% % visualizing the result.
% figure(2); imshow(visualization, []);

result = image;
for number = 1:result_number
    [value, vertical, horizontal] = image_maximum(corr_result);
    %result_scale = result(vertical, horizontal);
    box = make_bounding_box(vertical, horizontal, face_size);
    boxes(number, 1:4) = box;
    
    top = max(box(1),1);
    bottom = min(box(2), image_rows);
    left = max(box(3), 1);
    right = min(box(4), image_columns);
    window = image(top:bottom, left:right);
    boxes(number, 5) = value;
    boxes(number, 6) = std(window(:));
    
    h = size(window, 1);
    w = size(window, 2);
    c = 1;
    N_train = size(window, 3); 
    window = reshape(window, [h, w, c, N_train]);
    prob = predict(model, window)
    if(prob(2) > .5)
        corr_result(top:bottom, left:right) = -10;
        result = draw_rectangle1(result, top, bottom, left, right);
    end

    
end


end