function center = pca_detect_digit(image, mean_digit, eigenvectors, N)
    [rows, cols] = size(image);
    height = (rows-28);
    width = (cols-28);
    centers = height*width;
    scores = zeros(centers, 3);
    indice = 1;
    for i = 1:32
        for j = 1:32
          window = double(image(i:i+27, j:j+27));
          %figure(1);imshow(window, []);
          scores(indice, 1) = i+14;
          scores(indice, 2) = j+14;
          scores(indice, 3) = pca_score(window,mean_digit, eigenvectors, N);
          indice = indice+1;
        end
    end

    [values, indices] = sort(scores(:,3), 'ascend');

    center = zeros(1,2);
    center(1,1) = scores(indices(1),1);
    center(1,2) = scores(indices(1),2);
    top = center(1,1)-14;
    bottom = center(1,1)+14;
    left = center(1,2)-14;
    right = center(1,2)+14;
    
%     second_best = zeros(1,2);
%     second_best(1,1) = scores(indices(2),1);
%     second_best(1,2) = scores(indices(2),2);
%     top2 = second_best(1,1)-14;
%     bottom2 = second_best(1,1)+14;
%     left2 = second_best(1,2)-14;
%     right2 = second_best(1,2)+14;

    image = draw_rectangle1(image, top, bottom, left, right);
%     image = draw_rectanglex(image, top2, bottom2, left2, right2);

    figure();imshow(image, []);

end