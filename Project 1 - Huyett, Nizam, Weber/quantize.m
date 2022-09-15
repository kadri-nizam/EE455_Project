% QUANTIZE  changes the bitdepth of the input image to a specified number
% of bits
%
%   QUANTIZE(img, num_bits) returns an image matrix with its bitdepth
%   lowered to 2^num_bits levels
%
%   QUANTIZE(img, num_bits, method) modifies the bitdepth of img using the
%   method specified
%
%   Methods available to choose from:
%
%       1) Modulo (default): "mod" OR "modulo"
%       2) Domain Transform: "domain"
%
%   See also MOD, ROUND
%
%   Implementation details can be found at:
%
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-1.pdf

function new_img = quantize(img, num_bits, varargin)

    % Use modulo operation if no method is specified
    switch nargin
        case 2
            method = "mod"; 
        case 3
            method = varargin{1};
        otherwise
            error("Expected 2 or 3 inputs: (img, target_dim, [method])")
    end

    % Get the method we'll be using to quantize the grayscale intensity
    f = quantize_method(method);

    % Call the correct method
    new_img = f(img, num_bits);

end

%% Quantizing Methods

function new_img = mod_quantize(img, num_bits)
    
    % Get useful size variables and preallocate array for writing into
    [n_row, n_col] = size(img); 
    new_img = zeros(n_row, n_col);
    
    % Get the modulus for the modulo operation
    % bitshift is equivalent to 2^8 * 2^x
    modulus = bitshift(2^8, -num_bits);
   
    % Generate the new image
    for ii = 1:n_col
        for jj = 1:n_row
            new_img(jj, ii) = img(jj, ii) - mod(img(jj, ii), modulus);
        end
    end

end

function new_img = domain_quantize(img, num_bits)
    % Convert bit-depth to number of available levels
    num_level = 2^num_bits;

    % Convert the 8-bit img to floating point so we can perform 
    % math shenanigans then compress the domain to [0, 1]
    new_img = double(img)/255;

    % Expand the domain to the desired quantized level and round to whole
    % numbers. This gives us num_level contours on the image.
    % Normalize and rescale back to 255
    new_img = 255 * round(new_img * (num_level-1))/(num_level-1);

end

%% Helper Functions

function f = quantize_method(method)
    
    switch lower(method)
        % Use modulo operation to quantize the grayscale
        case {"mod", "modulo"}
            f =@(img, num_bits) mod_quantize(img, num_bits);

        % Use domain transform to quantize the grayscale
        case {"domain"}
            f =@(img, num_bits) domain_quantize(img, num_bits);

        otherwise
            error("Unknown downsampling method """ + method + """ provided.")
    end
    
end