% SPATIAL_DOWNSAMPLE  downsamples img to size (M, N)
%
%   SPATIAL_DOWNSAMPLE(img, [M, N]) returns an image matrix of dimensions 
%   (M, N), downsampled via max-pool
%
%   SPATIAL_DOWNSAMPLE(img, [M, N], method) downsamples img to size
%   (M, N) using the specified downsampling method
%
%   Methods available to choose from:
%
%       1) Max-Pool (default): "max" OR "max_pool"
%       2) Min-Pool: "min" OR "min_pool"
%       3) Avg-Pool: "avg" OR "avg_pool"
%
%   See also SPATIAL_UPSAMPLE
%
%   Implementation detail can be found at:
%
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-1.pdf

function new_img = spatial_downsample(img, target_dim, varargin)

    % Use max_pool as default if user did not provide a method
    % argument
    switch nargin
        case 2
            method = "max_pool"; 
        case 3
            method = varargin{1};
        otherwise
            error("Expected 2 or 3 inputs: (img, target_dim, [method])")
    end

    % Declare anonymous function corresponding to the chosen method
    f = downsample_method(method);

    % Prepare useful variables involving sizes
    [n_row, n_col] = size(img);
    target_row_size = target_dim(1);
    target_col_size = target_dim(2);

    blk_size.row = n_row/target_row_size;
    blk_size.col = n_col/target_col_size;

    % Preallocate array for better memory access during loop
    new_img = zeros(target_row_size, target_col_size);

    % Create array of indices that map pixel of new_img to pixel blocks in
    % img to simplify loop logic
    row_ind = 1:blk_size.row:n_row;
    col_ind = 1:blk_size.col:n_col;

    for col = 1:length(col_ind)
        for row = 1:length(row_ind)

            % Get pixel-block indices
            r_block = row_ind(row):row_ind(row)+blk_size.row-1;
            c_block = col_ind(col):col_ind(col)+blk_size.col-1;

            % Assign value in new_img pixel based on downsampling of
            % pixel-block in img
            new_img(row, col) = f(img(r_block, c_block));

        end
    end

end

%% Helper Functions

function f = downsample_method(method)
% DOWNSAMPLE_METHOD test

    switch lower(method)
        % Return max value within the entire matrix
        case {"max_pool", "max"}
            f =@(img_block) max(img_block, [], "all");

        % Calculate the mean using all elements in the matrix
        case {"avg_pool", "avg"}
            f =@(img_block) mean(img_block, "all");

        % Return min value within the entire matrix
        case {"min_pool", "min"}
            f =@(img_block) min(img_block, [], "all");

        otherwise
            error("Unknown downsampling method """ + method + """ provided.")
    end
    
end