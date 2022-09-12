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
%       Simply press "Run" on main.m in the MATLAB IDE. Documentation of
%       the 
%     
%   Authors:
%       Austin Huyett, Kadri Nizam, Hayden Weber
%
%   Last Updated: 09/11/2022

%% Clear MATLAB Environment

clc; clear; close all;
%% Imports

f = imread("walkbridge.tif", "tif");

% Alpha channel at index z=2 is not needed
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