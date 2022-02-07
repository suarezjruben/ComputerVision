function result = central_moment(shape, i, j)
[r,c] = size(shape);

RM_Area = raw_moment(shape, 0, 0);
RM_X = raw_moment(shape, 1, 0);
RM_Y = raw_moment(shape, 0, 1);

CM = 0;
for x = 1:r
    for y = 1:c
        CM = CM + (x - (RM_X/RM_Area))^i...
            * (y - (RM_Y/RM_Area))^j ...
            * shape(x,y);
    end
end
result = CM;
end