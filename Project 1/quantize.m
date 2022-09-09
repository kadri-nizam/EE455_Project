function new_img = quantize(img, num_bits)
    
    % Convert bit-depth to number of available levels
    num_level = 2^num_bits;

    % Convert the 8-bit img to floating point so we can perform 
    % math shenanigans then compress the domain to [0, 1]
    new_img = double(img)/double(0xff);

    % Expand the domain to the desired quantized level and round to whole
    % numbers. This gives us num_level contours on the image.
    % Finally, compress the domain back to [0, 1].
    new_img = round(new_img * (num_level-1))/(num_level-1);

    % Finally map the levels back onto an 8-bit colorbar
    new_img = uint8(new_img * double(0xff));

end