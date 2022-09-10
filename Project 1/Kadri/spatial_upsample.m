function new_img = spatial_upsample(img, target_dim, varargin)
% SPATIAL_UPSAMPLE  upsamples img to size (M, N)
%   SPATIAL_UPSAMPLE(img, [M, N]) returns an image matrix of dimensions 
%   (M, N), upsampled via nearest neighbour interpolation
%
%   SPATIAL_UPSAMPLE(img, [M, N], method) upsamples img to size
%   (M, N) using the specified upsampling method
%
%   Multiple methods are available to choose from:
%
%       1) Nearest-Neighbour: "nearest_neighbour" OR "nn" OR "proximal"
%       2) Bilinear Interpolation: "bilinear" OR "linear"
%
%   See also SPATIAL_DOWNSAMPLE.

    % Use nearest_neighbour as default if user did not provide a method
    % argument
    switch nargin
        case 2
            method = "nearest_neighbour"; 
        case 3
            method = varargin{1};
        otherwise
            error("Expected 2 or 3 inputs: (img, target_dim, [method])")
    end

    % Declare anonymous function corresponding to the chosen method
    % and call the function to upsample the input image
    f = upsample_method(method);
    new_img = f(img, target_dim);

end

%% Upsampling Functions

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

function img_block = cubic(img, target_dim)
    error("Method not yet implemented.")
end

function img_block = inverse_distance(img, target_dim)
    error("Method not yet implemented.")
end

%% Helper Functions

function f = upsample_method(method)

    switch lower(method)
        case {"nearest_neighbour", "nn", "proximal"}
            f =@(img, target_dim) nearest_neighbour(img, target_dim);

        case {"linear", "bilinear"}
            f =@(img, target_dim) bilinear(img, target_dim);
        case {"cubic"}
            f =@(img, target_dim) cubic(img, target_dim);

        case {"inverse_distance", "inv_distance"}
            f =@(img, target_dim) inv_distance(img, target_dim);

        otherwise
            error("Unknown upsampling method """ + method + """ provided.")
    end
    
end