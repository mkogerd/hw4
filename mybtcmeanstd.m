function [ mu , sigma ] = mybtcmeanstd( img_block , B1 , B2 )
%MYBTCMEANSTD calculates mean and standard deviation of an image block.
%   Compute the mean (mu) and standard deviation (sigma) of an image block
%   with B1 bits to store mu and B2 bits to store sigma.

img_block = double(img_block);

%  Calculate mean and standard deviation
mu = sum(img_block(:))/length(img_block(:));
sigma = sqrt(sum(sum((mu-img_block).^2))/length(img_block(:)));

% Compress mu and sigma to B1 and B2 bits respectively (LSB first)
mu_bits = de2bi(uint8(mu),8);
mu_bits(1:end-B1) = 0;
sigma_bits = de2bi(uint8(sigma),8);
sigma_bits(1:end-B2) = 0;

mu = bi2de(mu_bits);
sigma = bi2de(sigma_bits);

end

