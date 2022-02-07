

function result_img = oriented_edges(img, sigma, threshold, direction, tolerance)

image = img;
gray = double_gray(image);

dx = [-1 0 1; -2 0 2; -1 0 1] / 8;
dy = dx';

% rotating axis' so x is horizontal y is vertical
rot90x = imrotate(dx, 90, 'bilinear', 'crop');  
rot90y = imrotate(dy, 90, 'bilinear', 'crop');  

can_img = canny4(gray, sigma, 1.35 , threshold, 2*threshold);

blurred_gray = imfilter(gray, fspecial('gaussian', 9, 1.4), 'symmetric');

% thetas = gradient_orientations(dygray, dxgray);

dxgray = imfilter(blurred_gray, rot90x, 'same', 'symmetric');
dygray = imfilter(blurred_gray, rot90y, 'same', 'symmetric');

thetas =  atan2(dygray, dxgray);  %correct, angles increase clockwise
thetas = (thetas) / pi * 180;   % convert orientations to [0 180] range.
thetas(thetas < 0) = thetas(thetas < 0) + 180;
thetas(thetas > 180) = 180;

angle = direction;
angle = mod(angle, 180);

overlap_neg = angle - tolerance;
overlap_pos = angle + tolerance;

over = 0;
under = 0;

if (overlap_neg < 0)
    under = 1;
end 

if (overlap_pos > 180)
    overlap_pos = mod(overlap_pos, 180);
    over = 1;
end

if(under)
    % fprintf('Angle: %f\n', angle);
    angled_image = (thetas < angle + tolerance);
    angled_image = angled_image + (thetas > 180 - abs(overlap_neg));
    result_img = angled_image & can_img;
elseif(over)
    % fprintf('Angle: %f\n', angle);
    angled_image = (thetas > angle - tolerance);
    angled_image = angled_image + (thetas < 0 + overlap_pos);
    result_img = angled_image & can_img;
else
    % fprintf('Angle: %f\n', angle);  
    angled_image =  (thetas > (angle - tolerance) & thetas < (angle + tolerance));
    result_img = angled_image & can_img;
end




