function result = classify_digit_cm(digit, database)

image = digit > 0;
cms = zeros(10, 1);
cms(1,1) = central_moment(image, 0, 0);
cms(2,1) = central_moment(image, 0, 1);
cms(3,1) = central_moment(image, 1, 0);
cms(4,1) = central_moment(image, 1, 1);
cms(5,1) = central_moment(image, 2, 0);
cms(6,1) = central_moment(image, 0, 2);
cms(7,1) = central_moment(image, 2, 1);
cms(8,1) = central_moment(image, 1, 2);
cms(9,1) = central_moment(image, 3, 0);
cms(10,1) = central_moment(image, 0, 3);

dist = 1e+15;
index = 0;
for i = 1:5000
    data = database(1:10,i);
    eu_dist = euclidean_dist(cms, data);
    if(eu_dist < dist)
        dist = eu_dist;
        index = i;
    end
end

result = database(11,index);
end