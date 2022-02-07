function dist =  euclidean_dist(X, Y)
dist = sqrt(sum(sum((X-Y).^2)));
end