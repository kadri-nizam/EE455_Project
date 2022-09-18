% IMAGE_NOT is the unary image NOT operator
% IMAGE_NOT(A) returns the negation of iamge A

function output = image_not(A)
    
    [n_row, n_col] = size(A);

    output = zeros(n_row, n_col);

    for ii = 1:n_col
        for jj = 1:n_row
            output(jj, ii) = A(jj, ii) == 0;
        end
    end

    output = uint8(output);
end