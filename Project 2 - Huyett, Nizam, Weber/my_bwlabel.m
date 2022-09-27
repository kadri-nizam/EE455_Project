% MY_BWLABEL returns a matrix where connected-components in img are labeled.
% 8-connectivity is chosen by default.
%
%   MY_BWLABEL(img) returns labeled connected-comonents using 8-connectivity.
%
%   MY_BWLABEL(img, N) returns labeled connected-components using
%   N-connectivity. Only 4 and 8 connectivity are supported.
%
%   Processing flow:
%       1) Make a matrix of zeros identical to the input image called labeld_img
%       2) Iterate over the input image and check if pixel is foreground or
%       background
%           - If background, skip to next pixel
%           - If foreground, continue processing
%       3) Depending on user input, check 4 or 8-neighbour of pixel in
%       labeled_img for labels
%           - If there is no labels in the neighbourhood, assign a new label
%           - If there is continue processing
%       4) Collect only unique labels in the neighbourhood (sorted ascending
%       too). The smallest value is used as a key that maps to all other labels
%       in a dictionary. Label the pixel with the key. Repeat until whole image
%       is labeled
%       5) Iterate over labeled_img again, mapping non-key labels to keys.
%
%   See also:
%       COUNT_LABELS
%
%   Implementation details can be found at:
%
%       https://github.com/kadri-nizam/EE455_Project/raw/main/EE455___Project-2.pdf


function labeled_img = my_bwlabel(img, varargin)
    % Connectivity function uses static variable. Since the function is
    % internal, MATLAB does not reset the variable even when scope is
    % terminated. So we must clear it ourselves
    clear four_connectivity eight_connectivity

    % Default to 8-connectivity if user did not supply a connectivity input
    if nargin == 1
        cmethod = 8;
    else
        cmethod = varargin{1};
    end

    % Get connectivity method based on user input
    f = connectivity_method(cmethod);

    % Get useful size information and preallocate array
    [n_row, n_col] = size(img);
    labeled_img = zeros(n_row, n_col);

    % Matlab doesn't have dictionaries, so we'll allocate more memory than
    % probably needed as a janky solution. 
    %TODO: Figure out better way to do dictionaries
    map = cell(2000, 1);

    for col = 1:n_col
        for row = 1:n_row
            % Skip pixels that are not in the foreground
            if img(row, col) == 0
                continue
            end

            % Label the connected components without caring about connected
            % labels
            [label, label_map] = f(labeled_img, row, col);
            labeled_img(row, col) = label;

            % Add the connected label into the mapping for us to fix later
            if ~isempty(label_map)
                map{label} = cat(1, map{label}, label_map);
            end

        end
    end

    % Consolidate all connected mappings
    for ii = length(map):-1:1
        if isempty(map{ii})
            continue;
        end

        m = unique(map{ii});

        for x = m'
            labeled_img(labeled_img == x) = ii;
        end

    end

    % Make so that the labels increment by 1
    current_label = unique(labeled_img);
    num_label = length(current_label);

    for ii = 1:num_label
        labeled_img(labeled_img == current_label(ii)) = ii-1;
    end

end

%% Connectivity Test

function [label, map] = eight_connectivity(img, row, col)
    
    persistent cur_label;
    if isempty(cur_label)
        cur_label = 1;
    end

    [n_row, n_col] = size(img);

    % Treat cases at row edges of image
    if row == 1
        row_roi = row:row+1;
    elseif row == n_row
        row_roi = row-1:row;
    else
        row_roi = row-1:row+1;
    end

    % Treat cases at col edges of image
    if col == 1
        col_roi = col:col+1;
    elseif col == n_col
        col_roi = col-1:col;
    else
        col_roi = col-1:col+1;
    end    
    
    % Region of interest
    roi = img(row_roi, col_roi);
    
    % Get all unique label values in the roi
    map = unique(roi);
    
    % If there are no labels in the neighbourhood, assign a new one.
    % Otherwise, assign the lowest valued label (unique returns a sorted array) as the label
    if nnz(map) > 0
        map(map == 0) = [];
        label = map(1);
        
        % Pop the first element in map because we will be using it to label
        % everything else in map
        map(1) = [];
    else
        label = cur_label;
        map = [];

        cur_label = cur_label + 1;
    end

end

function [label, map] = four_connectivity(img, row, col)
    
    persistent cur_label;
    if isempty(cur_label)
        cur_label = 1;
    end

    [n_row, n_col] = size(img);

    % Treat cases at row edges of image
    if row == 1
        row_roi = row:row+1;
    elseif row == n_row
        row_roi = row-1:row;
    else
        row_roi = row-1:row+1;
    end

    % Treat cases at col edges of image
    if col == 1
        col_roi = col:col+1;
    elseif col == n_col
        col_roi = col-1:col;
    else
        col_roi = col-1:col+1;
    end    
    
    % Region of interest for 4-connectivity
    roi = img(row_roi, col);
    roi = cat(2, roi, img(row, col_roi)');
    
    % Get all unique label values in the roi
    map = unique(roi);
    
    % If there are no labels in the neighbourhood, assign a new one.
    % Otherwise, assign the lowest valued label (unique returns a sorted array) as the label
    if nnz(map) > 0
        map(map == 0) = [];
        label = map(1);
        
        % Pop the first element in map because we will be using it to label
        % everything else in map
        map(1) = [];
    else
        label = cur_label;
        map = [];

        cur_label = cur_label + 1;
    end

end

%% Helper Function

function f = connectivity_method(cmethod)
    switch cmethod
        case 4
            f =@(img, x, y) four_connectivity(img, x, y);
        case 8
            f =@(img, x, y) eight_connectivity(img, x, y);
        otherwise
            error("Connectivity method supplied is not recognized. Only 4 or 8 connectivity supported.")
    end
end

