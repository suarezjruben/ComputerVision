function result = classify_digit_hu(digit, database)
image = digit > 0;
cms = zeros(7, 1);
cms(1,1) = hu_moment(image, 1);
cms(2,1) = hu_moment(image, 2);
cms(3,1) = hu_moment(image, 3);
cms(4,1) = hu_moment(image, 4);
cms(5,1) = hu_moment(image, 5);
cms(6,1) = hu_moment(image, 6);
cms(7,1) = hu_moment(image, 7);


dist = 1e+15;
index = 0;
for i = 1:5000
    data = database(1:7,i);
    eu_dist = euclidean_dist(cms, data);
    if(eu_dist < dist)
        dist = eu_dist;
        index = i;
    end
end

result = database(8,index);
end
