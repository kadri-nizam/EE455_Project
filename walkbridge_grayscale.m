clear;

%Import "walkbridge.tif" image
f=imread('walkbridge.tif');
original_im=f(:,:,1);           %Get first layer of Tiff image
[M, N] = size(original_im);     %Get dimensions of "walkbridge.tif"
imtool(original_im);

%Reduce gray-scale of "walkbridge.tif" to 7 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),2) == 0
            gs_7b(x,y) = original_im(x,y)-1;
        else
            gs_7b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_7b);
imwrite(gs_7b, '7bit_grayscale.jpeg');


%Reduce gray-scale of "walkbridge.tif" to 6 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),4) ~= 0
            gs_6b(x,y) = original_im(x,y)-mod(original_im(x,y),4);
        else
            gs_6b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_6b);
imwrite(gs_6b, '6bit_grayscale.jpeg');



%Reduce gray-scale of "walkbridge.tif" to 5 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),8) ~= 0
            gs_5b(x,y) = original_im(x,y)-mod(original_im(x,y),8);
        else
            gs_5b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_5b);
imwrite(gs_5b, '5bit_grayscale.jpeg');



%Reduce gray-scale of "walkbridge.tif" to 4 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),16) ~= 0
            gs_4b(x,y) = original_im(x,y)-mod(original_im(x,y),16);
        else
            gs_4b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_4b);
imwrite(gs_4b, '4bit_grayscale.jpeg');



%Reduce gray-scale of "walkbridge.tif" to 3 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),32) ~= 0
            gs_3b(x,y) = original_im(x,y)-mod(original_im(x,y),32);
        else
            gs_3b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_3b);
imwrite(gs_3b, '3bit_grayscale.jpeg');



%Reduce gray-scale of "walkbridge.tif" to 2 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),64) ~= 0
            gs_2b(x,y) = original_im(x,y)-mod(original_im(x,y),64);
        else
            gs_2b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_2b);
imwrite(gs_2b, '2bit_grayscale.jpeg');



%Reduce gray-scale of "walkbridge.tif" to 1 bits
for x = 1 : M
    for y = 1 : N
        if mod(original_im(x,y),128) ~= 0
            gs_1b(x,y) = original_im(x,y)-mod(original_im(x,y),128);
        else
            gs_1b(x,y) = original_im(x,y);
        end
    end
end
imtool(gs_1b);
imwrite(gs_1b, '1bit_grayscale.jpeg');

