%   Project 2 - Connected-Component Labeling and Set Operations
%
%   Associated files:
%       1) main.m - Main logic
%       2) count_labels.m - Get counts of labels in a labeled image
%       3) Logical Set Operations
%           a) image_and.m - Binary AND operator
%           b) image_or.m - Binary OR operator
%           c) image_xor.m - Binary XOR operator
%           d) image_not.m - Unary NOT operator
%       4) image_min.m - Minimum operator
% 
%   Restrictions:
%       - Functions are only tested on grayscale and binary images.
%       - The bwlabel function used for connected-component labeling
%       requires MATLAB's Image Processing Toolbox.
%
%   Running the project:
%       Simply press "Run" on main.m in the MATLAB IDE or type "main" into 
%       the MATLAB console. Discussion of the algorithms in this
%       code base as well as the results is covered in our report at
%       
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-2.pdf
%     
%   See also:
%       COUNT_LABELS, MY_BWLABEL, IMAGE_AND, IMAGE_OR, IMAGE_XOR, IMAGE_NOT, IMAGE_MIN
%
%   Authors:
%       Austin Huyett, Kadri Nizam, Hayden Weber
%
%   Last Updated: 09/23/2022

%% Clear MATLAB Environment

clc; clear; close all;

%% File Imports

lenna = imread("lenna.gif", "gif");
match1 = imread("match1.gif", "gif");
match2 = imread("match2.gif", "gif");
mandrill = imread("mandril_gray.tif", "tif");
cameraman = imread("cameraman.tif", "tif");

%% Question 1 - Bright Region Extraction

% Rather than an arbitrary value, we only allow a certain percentage of the
% maximum pixel value to pass
thresh_percent = 60;
threshold = thresh_percent/100 * double(max(lenna, [], "all"));
f_thresh = lenna > threshold;

% Label the image with 8-connectivity. If the Image Processing Toolbox is
% not available, use the custom written connected-component labeler
try
    [f_label, ~] = bwlabel(f_thresh, 8);
catch
    [f_label, ~] = my_bwlabel(f_thresh, 8);
end

% Map the label numbers into RGB colors
f_rgb = label2rgb(f_label);

% Get the labels and their associated number of counts
[count, label] = count_labels(f_label);

% Prepare to get top N labels
N = 4;
top_N = label(1:N);
ind = 0;

% We perform a union of the boolean masks to get a set of of pixels that
% are our top N largest labels
for ii = 1:N
    ind = ind | f_label == top_N(ii);
end

% Now do an intersect between flabela and the boolean masks. Where the mask
% is 1, we get the value of flabel. Where it's 0, we get 0.
f_top_N = f_label .* ind;

% Write out all pertinent images to file
imwrite(logical(f_thresh), "output/Q1_lenna_threhold.tif", "tif");
imwrite(uint8(f_rgb), "output/Q1_lenna_rgb_labeled.tif", "tif");
imwrite(uint8(label2rgb(f_top_N)), sprintf("output/Q1_lenna_rgb_top_%d.tif", N), "tif");


%% Question 2 - Logical Operations

match_not = image_not(match1);
match_and = image_and(match1, match2);
match_or = image_or(match1, match2);
match_xor = image_xor(match1, match2);

cameramandrill = image_min(mandrill, cameraman);

% Write out all pertinent images to file
imwrite(logical(match_not), "output/Q2_NOT.tif", "tif");
imwrite(logical(match_and), "output/Q2_AND.tif", "tif");
imwrite(logical(match_or), "output/Q2_OR.tif", "tif");
imwrite(logical(match_xor), "output/Q2_XOR.tif", "tif");

imwrite(uint8(cameramandrill), "output/Q2_MIN.tif", "tif")