%   Project 1 - Digital Image Quantization
%
%   Associated files:
%       1) main.m - Main logic
%       2) spatial_upsample.m - Upsampling logic
%           a) nearest_neighbour.m - Nearest neighbour interpolation
%           b) bilinear.m - Bilinear interpolation
%       3) spatial_downsample.m - Downsampling logic
%       4) quantize.m - Grayscale quantization logic
% 
%   Restrictions:
%       Our project assumes that all input/output image sizes are
%       restricted to powers of 2
%
%   Running the project:
%       Simply press "Run" on main.m in the MATLAB IDE or type "main" into 
%       the MATLAB console. Discussion of the algorithms in this
%       code base as well as the results is covered in http://google.com
%     
%   See also:
%       SPATIAL_UPSAMPLE, SPATIAL_DOWNSAMPLE, QUANTIZE, NEAREST_NEIGHBOUR,
%       BILINEAR
%
%   Authors:
%       Austin Huyett, Kadri Nizam, Hayden Weber
%
%   Last Updated: 09/11/2022

%% Clear MATLAB Environment

clc; clear; close all;

%% File Imports

f = imread("walkbridge.tif", "tif");
img = f(:, :, 1);

%% Question 1 - Downsampling and Upsampling via Nearest-Neighbour

target_dim = [256, 128, 32];

for ii = target_dim
    downsampled = spatial_downsample(img, ii .* [1, 1]);
    upsampled = spatial_upsample(downsampled, 512 .* [1, 1]);

    filename = sprintf("output/Q1_downsample_%dx%d.tif", ii .* [1, 1]);
    imwrite(uint8(upsampled), filename, "tif");
end

%% Question 2 - Upsampled 32x32 via Bilinear

downsampled = spatial_downsample(img, 32 .* [1, 1]);
upsampled = spatial_upsample(downsampled, 512 .* [1, 1], "bilinear");

filename = sprintf("output/Q2_up_bilinear_%dx%d.tif", 32 .* [1, 1]);
imwrite(uint8(upsampled), filename, "tif");

%% Question 3 - Grayscale Quantization

level = 7:-1:1;

for ii = level
    quantized = quantize(img, ii);

    filename = sprintf("output/Q3_quantized_%dbit.tif", ii);
    imwrite(uint8(quantized), filename, "tif");
end

%% Question 4 - Downsample 256x256, Quantize 6-bit

downsampled = spatial_downsample(img, 256 .* [1, 1]);
upsampled = spatial_upsample(downsampled, 512 .* [1, 1], "bilinear");

quantized = quantize(upsampled, 6);

filename = sprintf("output/Q4_quantized_%dx%d_6bit.tif", 256 .* [1, 1]);
imwrite(uint8(quantized), filename, "tif");







