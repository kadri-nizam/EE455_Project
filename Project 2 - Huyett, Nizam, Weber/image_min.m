% IMAGE_MIN is the binary image MIN operator
% IMAGE_MIN(A, B) returns a composite between image A and B where the
% minimum between the two images at every pixel is extracted

function output = image_min(A, B)
    % Ensure that the input images are the same size
    assert(all(size(A) == size(B)), "Input images don't match in size")
    
    [n_row, n_col] = size(A);

    output = zeros(n_row, n_col);

    for ii = 1:n_col
        for jj = 1:n_row
            if A(jj, ii) < B(jj, ii)
                output(jj, ii) = A(jj, ii);
            else
                output(jj, ii) = B(jj, ii);
            end
        end
    end
     
    output = uint8(output);
end