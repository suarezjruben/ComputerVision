close all;
clear;
clc;

% Test images
test_image = double(imread('test.bmp'));
test_1 = test_image(119:177, 299:333, :);
test_2 = test_image(224:261, 229:410, :);
test_3 = test_image(224:278, 387:410, :);
test_non_skin = test_image(332:457, 36:570, :);

% Module 1
training_A = double(imread('training_A.bmp'));
m1_patch_1 = training_A(122:150, 297:338, :);   % patch 1
m1_patch_2 = training_A(246:265, 117:145, :);   % patch 2
[m1_r_mean, m1_g_mean, m1_r_std, m1_g_std] = norm_rg_space(m1_patch_1,m1_patch_2); 
m1_skin_test_1 = skin_detection(test_1, m1_r_mean, m1_r_std, m1_g_mean, m1_g_std);
m1_skin_test_2 = skin_detection(test_2, m1_r_mean, m1_r_std, m1_g_mean, m1_g_std);
m1_skin_test_3 = skin_detection(test_3, m1_r_mean, m1_r_std, m1_g_mean, m1_g_std);
m1_no_skin_test = skin_detection(test_non_skin, m1_r_mean, m1_r_std, m1_g_mean, m1_g_std);
    % Evaluation
    X1 = [];
    Y1 = [];
    for i = 0:0.1:333
        [skin_accuracy1, nonskin_accuracy1] = eval_module(m1_skin_test_1, m1_skin_test_2, m1_skin_test_3, m1_no_skin_test, i);
        X1 = [X1, skin_accuracy1];
        Y1 = [Y1, nonskin_accuracy1];
    end

% Module 2
training_B = double(imread('training_B.bmp'));
m2_patch_1 = training_B(189:230, 213:293, :);   % patch 1
m2_patch_2 = training_B(376:423, 63:120, :);    % patch 2
m2_patch_3 = training_B(413:471, 404:455, :);   % patch 3
[m2_r_mean, m2_g_mean, m2_r_std, m2_g_std] = norm_rg_space(m2_patch_1,m2_patch_2, m2_patch_3);
m2_skin_test_1 = skin_detection(test_1, m2_r_mean, m2_r_std, m2_g_mean, m2_g_std);
m2_skin_test_2 = skin_detection(test_2, m2_r_mean, m2_r_std, m2_g_mean, m2_g_std);
m2_skin_test_3 = skin_detection(test_3, m2_r_mean, m2_r_std, m2_g_mean, m2_g_std);
m2_no_skin_test = skin_detection(test_non_skin, m2_r_mean, m2_r_std, m2_g_mean, m2_g_std);
    % Evaluation
    X2 = [];
    Y2 = [];
    for i = 0:0.1:361
        [skin_accuracy2, nonskin_accuracy2] = eval_module(m2_skin_test_1, m2_skin_test_2, m2_skin_test_3, m2_no_skin_test, i);
        X2 = [X2, skin_accuracy2];
        Y2 = [Y2, nonskin_accuracy2];
    end

% Module 3
positive_histogram = read_double_image('positives.bin');
negative_histogram = read_double_image('negatives.bin');
m3_skin_test_1 = detect_skin(test_1, positive_histogram,  negative_histogram);
m3_skin_test_2 = detect_skin(test_2, positive_histogram,  negative_histogram);
m3_skin_test_3 = detect_skin(test_3, positive_histogram,  negative_histogram);
m3_no_skin_test = detect_skin(test_non_skin, positive_histogram,  negative_histogram);
m3_skin_test_1 = m3_skin_test_1 * 100;
m3_skin_test_2 = m3_skin_test_2 * 100;
m3_skin_test_3 = m3_skin_test_3 * 100;
m3_no_skin_test = m3_no_skin_test * 100;
    % Evaluation
    X3 = [];
    Y3 = [];
    for i = 0:0.01:100
        [skin_accuracy3, nonskin_accuracy3] = eval_module(m3_skin_test_1, m3_skin_test_2, m3_skin_test_3, m3_no_skin_test, i);
        X3 = [X3, skin_accuracy3];
        Y3 = [Y3, nonskin_accuracy3];
    end
    
% Plot
figure(2);
plot(X1, Y1, 'k-');
hold on;
plot(X2, Y2, 'r--');
plot(X3, Y3, 'b:');
set(gca, 'XLim', [0 105]);
set(gca, 'YLim', [0 105]);
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
xticks([0:10:100]);
yticks([0:10:100]);
legend('Module 1', 'Module 2', 'Module 3', 'Location', 'SouthWest');

% For Mean and STD calculation
function [r_mean, g_mean, r_std, g_std] = norm_rg_space(patch1, patch2, patch3)
    if(nargin > 1)
        % Patch 1
        red_1 = patch1(:, :, 1);
        green_1 = patch1(:, :, 2);
        blue_1 = patch1(:, :, 3);
        red_1 = red_1(:);
        green_1 = green_1(:);
        blue_1 = blue_1(:);
        % Patch 2
        red_2 = patch2(:, :, 1);
        green_2 = patch2(:, :, 2);
        blue_2 = patch2(:, :, 3);
        red_2 = red_2(:);
        green_2 = green_2(:);
        blue_2 = blue_2(:);
        % RGBs
        red = cat(1, red_1, red_2);
        green = cat(1, green_1, green_2);
        blue = cat(1, blue_1, blue_2);
        if(nargin == 3)
            % Patch 3
            red_3 = patch3(:, :, 1);
            green_3 = patch3(:, :, 2);
            blue_3 = patch3(:, :, 3);
            red_3 = red_3(:);
            green_3 = green_3(:);
            blue_3 = blue_3(:);
            % RGBs
            red = cat(1, red, red_3);
            green = cat(1, green, green_3);
            blue = cat(1, blue, blue_3);
        end
    end
    % Sample total
    sample_total = red + green + blue;
    % RG Color probabilites
    red_prob = red ./ sample_total;
    red_prob(isnan(red_prob)) = 0;
    green_prob = green ./ sample_total;
    green_prob(isnan(green_prob)) = 0;

    r_mean = mean(red_prob);
    g_mean = mean(green_prob); 
    r_std = std(red_prob);
    g_std = std(green_prob);

end

% For Skin detection
function skin = skin_detection(double_image, r_mean, r_std, g_mean, g_std)
[rows, cols, bands] = size(double_image);
skin = zeros(rows, cols);
    for row = 1:rows
        for col = 1:cols
            red = double_image(row, col, 1);
            green = double_image(row, col, 2);
            blue = double_image(row, col, 3);

            sum = red+green+blue;
            if sum > 0
                r = red / sum;
                g = green / sum;
            else
                r = 0;
                g = 0;
            end

            r_prob = gaussian_probability(r_mean, r_std, r);
            g_prob = gaussian_probability(g_mean, g_std, g);
            prob = r_prob * g_prob;
            skin(row, col) = prob;
        end
    end
end
 
%For evaluation
function [skin_accuracy, nonskin_accuracy] = eval_module(skin_patch1, skin_patch2, skin_patch3, noskin_patch, threshold)

    skin_pixel_count = 0;
    total_pixel_count = 0;
    
    % Skin Patch 1:
    skin_pixel_count = skin_pixel_count + numel(find(skin_patch1 > threshold));
    total_pixel_count = total_pixel_count + numel(skin_patch1);
    
    % Skin Patch 2: 
    skin_pixel_count = skin_pixel_count + numel(find(skin_patch2 > threshold));
    total_pixel_count = total_pixel_count + numel(skin_patch2);
    
    % Skin Patch 3:
    skin_pixel_count = skin_pixel_count + numel(find(skin_patch3 > threshold));
    total_pixel_count = total_pixel_count + numel(skin_patch3);
    
    % Non-skin Patch:
    nonskin_pixel_count = numel(find(noskin_patch < threshold));
    total_nonskin_pixel_count = numel(noskin_patch);
    
    skin_accuracy = skin_pixel_count/total_pixel_count*100;
    nonskin_accuracy = nonskin_pixel_count/total_nonskin_pixel_count*100;

end
