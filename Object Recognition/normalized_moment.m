function result = normalized_moment(shape, i, j)

cm_00 = central_moment(shape, 0, 0);

if(i == 1 && j == 0 || i == 0 && j == 1)
    NM = central_moment(shape, i, j)/(cm_00);
else 
    NM = central_moment(shape, i, j)/(cm_00)^(1+((i+j)/2));
end
result = NM;

end