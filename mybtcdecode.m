function [ decoded_block ] = mybtcdecode ( binary_block , mu , sigma )
%MYBTCDECODE decodes a binary block using mean and standard deviation. 
%   If b(p) = 1, decode = mu + sigma/A
%   If b(p) = 0, decode = mu - sigma*A
%Where A = sqrt(P/Q), P being the 1 count and Q being the 0 count.

% Count 1s and 0s and calculate A
ones = (binary_block == 1);
zeros = (binary_block == 0);
Q = sum(ones(:));
P = sum(zeros(:));
A = sqrt(Q/P);

% Calculate decoded block
decoded_block_Q = ones*double(mu) + ones*double(sigma)/A;
decoded_block_P = zeros*double(mu) - zeros*double(sigma)*A;
decoded_block = uint8(decoded_block_Q + decoded_block_P);

end

