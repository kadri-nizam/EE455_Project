% IMAGE_XOR is the binary image XOR operator
% IMAGE_XOR(A, B) returns the exclusive or between image A and
% image B

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
     
    output = uint8(output);
end