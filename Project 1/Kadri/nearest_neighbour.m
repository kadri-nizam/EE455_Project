function new_img = nearest_neighbour(img, target_dim)
    % Prepare variables involving sizes
    [n_row, n_col] = size(img);
    target_row_size = target_dim(1);
    target_col_size = target_dim(2);

    blk_size.row = target_row_size/n_row;
    blk_size.col = target_col_size/n_col;

    % Preallocate array for better memory access during loop
    new_img = zeros(target_row_size, target_col_size);

    % Create array of indices that map pixel of new_img to pixel blocks in
    % img to simplify loop logic
    row_ind = 1:blk_size.row:target_row_size;
    col_ind = 1:blk_size.col:target_col_size;

    for col = 1:n_col
        for row = 1:n_row

            % Get pixel-block indices
            r_block = row_ind(row):row_ind(row)+blk_size.row-1;
            c_block = col_ind(col):col_ind(col)+blk_size.col-1;

            % Assign value in new_img pixel-block based on upsampling of
            % pixel(s) in img
            new_img(r_block, c_block) = img(row, col);

        end
    end
end