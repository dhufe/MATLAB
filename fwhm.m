function [ tp, max_idx, min_left_idx, min_right_idx] = fhmw( x, y, trsh )
%Computes the full width at half maximum, or thresholded values.
% 
% x: index vector (e.g. time, frequency )
% y: amplitude vector
% trsh: optional treshold 
%
% Implemented by Daniel Hufschläger © 2021
%

if ~exist('trsh','var')
     % third parameter does not exist, so default it to something
     trsh = .5;
else 
     trsh = 1 - trsh;
end

[max_val,max_idx] = max(y);

% get nearest value left 
[~,min_left_idx]=min( abs ( y(1:max_idx - 1) - (max_val - trsh )) );

% get nearest value right 
[~,min_right_idx]=min( abs ( y(max_idx + 1:end) - (max_val - trsh) ) );
min_right_idx = min_right_idx + max_idx - 1;

% width using indices and the passed index vector 
tp = x ( min_right_idx ) - x ( min_left_idx );

end

