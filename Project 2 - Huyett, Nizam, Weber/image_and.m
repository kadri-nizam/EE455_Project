% IMAGE_AND is the binary image AND operator
% IMAGE_AND(A, B) returns the intersection between image A and
% image B

function output = image_and(A, B)
    % Ensure that the input images are the same size
    assert(all(size(A) == size(B)), "Input images don't match in size")
    
    [n_row, n_col] = size(A);

    output = zeros(n_row, n_col);

    for ii = 1:n_col
        for jj = 1:n_row
            output(jj, ii) = A(jj, ii) * B(jj, ii);
        end
    end
     
    output = logical(output);
end