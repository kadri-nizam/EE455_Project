clear;

f=imread('walkbridge.tif');
original_walkbridge=f(:,:,1);
[M, N] = size(original_walkbridge)
imtool(original_walkbridge);
imwrite(original_walkbridge, "orignal_walkbridge.jpeg");

%for a = 1 : 512
%    for b = 1 : 512
%        f2(a,b) = f(a,b);
%    end
%end

%imtool(f2);

%create downsample 256x256
for x = 1:M
    for y = 1:N
        if mod(x,2) == 0 & mod(y,2) == 0
            ds256(x/2, y/2) = original_walkbridge(x,y);
        end
    end
end

imtool(ds256);

%Nearest neighbor interpolation for 256x256
[X, Y] = size(ds256);
for x = 1:X
    for y = 1:Y
        upsamp256(x*2,y*2) = ds256(x, y);
        upsamp256((x*2)-1,y*2) = ds256(x, y);
        upsamp256(x*2,(y*2)-1) = ds256(x, y);
        upsamp256((x*2)-1,(y*2)-1) = ds256(x, y);
    end
end

imtool(upsamp256);
imwrite(upsamp256, "walkbridge256x256.jpeg");


%create downsample of 'walkbridge,tif' 128x128
for x = 1:M
    for y = 1:N
        if mod(x,4) == 0 & mod(y,4) == 0
            ds128(x/4, y/4) = original_walkbridge(x,y);
        end
    end
end

imtool(ds128);

%Nearest neighbor interpolation for 128x128
[X, Y] = size(ds128);
for x = 1:X
    for y = 1:Y
        upsamp128(x*4,y*4) = ds128(x, y);
        upsamp128((x*4)-1,y*4) = ds128(x, y);
        upsamp128((x*4)-2,y*4) = ds128(x, y);
        upsamp128((x*4)-3,y*4) = ds128(x, y);
        upsamp128(x*4,(y*4)-1) = ds128(x, y);
        upsamp128(x*4-1,(y*4)-1) = ds128(x, y);
        upsamp128(x*4-2,(y*4)-1) = ds128(x, y);
        upsamp128(x*4-3,(y*4)-1) = ds128(x, y);
        upsamp128(x*4,(y*4)-2) = ds128(x, y);
        upsamp128(x*4-1,(y*4)-2) = ds128(x, y);
        upsamp128(x*4-2,(y*4)-2) = ds128(x, y);
        upsamp128(x*4-3,(y*4)-2) = ds128(x, y);
        upsamp128(x*4,(y*4)-3) = ds128(x, y);
        upsamp128(x*4-1,(y*4)-3) = ds128(x, y);
        upsamp128(x*4-2,(y*4)-3) = ds128(x, y);
        upsamp128(x*4-3,(y*4)-3) = ds128(x, y);
        
    end
end

imtool(upsamp128);
imwrite(upsamp128, "walkbridge128x128.jpeg");

%create downsample of 'walkbridge.tif' 32x32
for x = 1:512
    for y = 1:512
        if mod(x,16) == 0 & mod(y,16) == 0
            ds32(x/16, y/16) = original_walkbridge(x,y);
        end
    end
end

imtool(ds32);


%Nearest neighbor interpolation for 32x32
[X, Y] = size(ds32);
for x = 1 : X
    for y = 1 : Y
        for a = 0 : 15
            for b = 0 : 15
                upsamp32(x*16-a,y*16-b) = ds32(x,y);
            end
        end
    end
end
imtool(upsamp32);
imwrite(upsamp32, "walkbridge32x32.jpeg");
