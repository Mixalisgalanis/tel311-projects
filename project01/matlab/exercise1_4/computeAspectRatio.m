function aRatio = computeAspectRatio(image)
    % Fill your code
    aRatio = zeros;
    for i = 1:size(image, 1) %iterate through all images    
        min_width_idx = 14; max_width_idx = 14;
        min_height_idx = 14; max_height_idx = 14;
        for imrow = 1:size(image, 2)
            for imcol = 1:size(image, 3)
                pixel = image(i, imrow, imcol);
                if (pixel ~= 0)
                    min_height_idx = min(min_height_idx, imrow);
                    max_height_idx = max(max_height_idx, imrow);
                    min_width_idx = min(min_width_idx, imcol);
                    max_width_idx = max(max_width_idx, imcol);
                end
            end
        end
        width = max_width_idx - min_width_idx;
        height = max_height_idx - min_height_idx;
        aRatio(i) = width / height;
    end
end

