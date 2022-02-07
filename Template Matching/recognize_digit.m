function result = recognize_digit(image, average2, average3)

    norm_corr_2 = normalized_correlation(image, average2);
    norm_corr_2 = norm_corr_2 > 0.1;
    total_2 = sum(norm_corr_2(:));
    
    norm_corr_3 = normalized_correlation(image, average3);
    norm_corr_3 = norm_corr_3 > 0.1;
    total_3 = sum(norm_corr_3(:));


    if total_2 > total_3
        result = 2;
    else
        result = 3;
    end
    
end