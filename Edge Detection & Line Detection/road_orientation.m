function result_angle = road_orientation(image)
    img = image;
    result_angle = 0;
    counter = 0;

    for i = 0:180
        result_img = oriented_edges(img, 1.4, 4, i, 15);
        if(counter < sum(result_img(:)))
            counter = sum(result_img(:));
            result_angle = i;
        end
    end

end