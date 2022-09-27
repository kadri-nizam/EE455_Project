%COUNT_LABELS returns the occurrence count for every connected-component in
%a labeled image, sorted in descending order of counts
%   [count, label] = COUNT_LABELS(f_labeled) returns the count of
%   occurrence for each label in f_labeled
%
%   Processing flow:
%       1) Each label itself is unique and can be used as an index when
%          iterating through f_labeled
%       2) For each value (label) found in f_labeled, the count array at 
%          index = value + 1 is incremented by 1
%       3) Repeat until f_labeled is fully iterated for an O(N) execution
%
%   See also:
%       MY_BWLABEL
%
%   Further implementation details can be found at:
%       http://google.com

function [count, label] = count_labels(f_labeled)

    % Flatten img_label into a 1d array for easier processing
    f_labeled = f_labeled(:);

    % Find the maximal label value to know how many labels there are
    n_labels = max(f_labeled);

    % img_label ranges from 1 to n_labels. Fortuitously, we can simply use
    % the labels as indices though we must first remove zeros
    f_labeled(f_labeled == 0) = [];

    % Preallocate count array for more efficiency and make the label array
    % associated with the counts.
    count = zeros(n_labels, 1);
    label = (1:n_labels)';
    
    % Count occurence of the labels
    for ii = 1:length(f_labeled)
        k = f_labeled(ii);
        count(k) = count(k) + 1;
    end
    
    % Finally, sort in descending order of counts
    [count, ind_sort] = sort(count, "descend");
    
    % Rearrange label to follow the sorted index
    label = label(ind_sort);
end

