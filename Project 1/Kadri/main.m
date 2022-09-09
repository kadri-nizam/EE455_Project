clc; clear; close all;
%% Imports

f = imread("walkbridge.tif", "tif");
img = f(:, :, 1);

%% Downsample Spatial Resolution

img_d32 = spatial_downsample(img, 128 .* [1, 1]);

%% Upsample Spatial Resolution

figure
subplot(121)
imshow(img, [0, 255])
subplot(122)
imshow(spatial_upsample(img_d32, [512, 512]), [0, 255])


%% Quantize Gray level

figure
subplot(121)
imshow(img, [0, 255])
subplot(122)
imshow(quantize(img, 3), [0, 255])