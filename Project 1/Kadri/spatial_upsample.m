% SPATIAL_UPSAMPLE  upsamples img to size (M, N)
%
%   SPATIAL_UPSAMPLE(img, [M, N]) returns an image matrix of dimensions 
%   (M, N), upsampled via nearest neighbour interpolation
%
%   SPATIAL_UPSAMPLE(img, [M, N], method) upsamples img to size
%   (M, N) using the specified upsampling method
%
%   Methods available to choose from:
%
%       1) Nearest-Neighbour (default): "nearest_neighbour" OR "nn" OR "proximal"
%       2) Bilinear Interpolation: "bilinear" OR "linear"
%
%   See also NEAREST_NEIGHBOUR, BILINEAR, SPATIAL_DOWNSAMPLE
%
%   Implementation detail can be found at:
%
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-1.pdf

function new_img = spatial_upsample(img, target_dim, varargin)

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





%% Functions to be implemented in the future

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