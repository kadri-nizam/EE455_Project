% IMAGE_XOR is the binary image XOR operator
% IMAGE_XOR(A, B) returns the exclusive or between image A and
% image B
%
%   See also:
%       IMAGE_AND, IMAGE_OR, IMAGE_NOT, IMAGE_MIN
%
%   %   Implementation details can be found at:
%
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-2.pdf

function output = image_xor(A, B)
    % Ensure that the input images are the same size
    assert(all(size(A) == size(B)), "Input images don't match in size")
    
    [n_row, n_col] = size(A);

    output = zeros(n_row, n_col);

    for ii = 1:n_col
        for jj = 1:n_row
            output(jj, ii) = A(jj, ii) ~= B(jj, ii);
        end
    end
     
    output = logical(output);
end