function new_img = bilinear(img, target_dim)
    % Prepare variables involving sizes
    [n_row, n_col] = size(img);
    target_row_size = target_dim(1);
    target_col_size = target_dim(2);

    d_row = (n_row-1) / (target_row_size-1);
    d_col = (n_col-1) / (target_col_size-1);
    
    % Preallocate array for better memory access during loop   
    new_img = zeros(target_row_size, target_col_size);

    % Create sub-pixel array with d_col and d_row spacing for interpolating
    % pixel values later
    x = 1:d_col:n_col;
    y = 1:d_row:n_row;

    % Helper array of indices where the pixel in the old image maps to the new one
    col_ind = round(1:1/d_col:target_col_size);
    row_ind = round(1:1/d_row:target_row_size);

    % Map pixel values from old to new
    for ii = 1:length(col_ind)
        for jj = 1:length(col_ind)
            new_img(row_ind(jj), col_ind(ii)) = img(jj, ii);
        end
    end

    % Interpolate along columns
    for ii = 1:length(col_ind)-1
        left = new_img(:, col_ind(ii));
        right = new_img(:, col_ind(ii+1));

        col_ratio = x(col_ind(ii):col_ind(ii+1));
        col_ratio = col_ratio - col_ratio(1);
    
        new_img(:, col_ind(ii):col_ind(ii+1)) = left + col_ratio.*(right-left);
    end

    % Interpolate along rows
    for jj = 1:length(row_ind)-1
        top = new_img(row_ind(jj), :);
        bottom = new_img(row_ind(jj+1), :);

        row_ratio = y(row_ind(jj):row_ind(jj+1));
        row_ratio = row_ratio - row_ratio(1);
    
        new_img(row_ind(jj):row_ind(jj+1), :) = top + row_ratio'.*(bottom-top);
    end

end