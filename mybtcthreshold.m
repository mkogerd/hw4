function [ binary_block ] = mybtcthreshold ( img_block , mu )
%MYBTCTHRESHOLD computes a block truncation coding binary block.
%   MYBTCTHRESHOLD thresholds the image block at the mean (mu) in order to
%   produce a binary matrix.

binary_block = img_block > mu;

end

