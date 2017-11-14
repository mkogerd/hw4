clear();
%% 1. Block Truncation Coding (BTC) (a)
% mybtcmeanstd.m

%% 1. Block Truncation Coding (BTC) (b)
% mybtcthreshold.m

%% 1. Block Truncation Coding (BTC) (c)
% mybtcdecode.m

%% 1. Block Truncation Coding (BTC) (d)
% Read in the image, itjoker.jpg, and convert it into gray scale.
img = imread('img/itjoker.jpg');
img_gray = rgb2gray(img);

% Compute block mean images
[mu_a, sigma_a] = mybtcmeanstd(img_gray, 2, 1);
[mu_b, sigma_b] = mybtcmeanstd(img_gray, 3, 4);
[mu_c, sigma_c] = mybtcmeanstd(img_gray, 6, 5);
btc_a = mybtcthreshold(img_gray, mu_a);
btc_b = mybtcthreshold(img_gray, mu_b);
btc_c = mybtcthreshold(img_gray, mu_c);
btc_a = mybtcdecode(btc_a, mu_a, sigma_a);
btc_b = mybtcdecode(btc_b, mu_b, sigma_b);
btc_c = mybtcdecode(btc_c, mu_c, sigma_c);

% Show images
figure('NumberTitle', 'off', 'Name', '1(d)');
subplot(221); imshow(img_gray); title('Original');
subplot(222); imshow(btc_a); title('B1=2, B2=1');
subplot(223); imshow(btc_b); title('B1=3, B2=4');
subplot(224); imshow(btc_c); title('B1=6, B2=5');

%% 1. Block Truncation Coding (BTC) (e)
% Compute the BTC binary blocks using the same three settings of B1 and 
% B2 above. Show the original and the three binary block images in a 2x2 
% grid, and comment on what you observe.

% img_gray = uint8(randi(255,8,8))
% img_gray = uint8([50 50 50 0 200 150 150 150;
%             50 50 0 50 150 200 150 150;
%             0 0 0 50 200 200 150 200;
%             0 0 50 0 200 200 200 150;]);
blocks = im2col(img_gray, [4 4], 'distinct');

% Compute BTC binary blocks
binary_a = blocks;
mu_sigma_a = zeros(2,size(blocks,2));
for n = 1:size(blocks,2)
    block = binary_a(:,n);
    [mu_sigma_a(1,n), mu_sigma_a(2,n)] = mybtcmeanstd(block, 2, 1);
    btc = mybtcthreshold(block, mu_sigma_a(1,n));
    binary_a(:,n) = btc;
end
binary_a = double(col2im(binary_a, [4 4], size(img_gray), 'distinct'));

binary_b = blocks;
mu_sigma_b = zeros(2,size(blocks,2));
for n = 1:size(blocks,2)
    block = binary_b(:,n);
    [mu_sigma_b(1,n), mu_sigma_b(2,n)] = mybtcmeanstd(block, 3, 4);
    btc = mybtcthreshold(block, mu_sigma_b(1,n));
    binary_b(:,n) = btc;
end
binary_b = double(col2im(binary_b, [4 4], size(img_gray), 'distinct'));

binary_c = blocks;
mu_sigma_c = zeros(2,size(blocks,2));
for n = 1:size(blocks,2)
    block = binary_c(:,n);
    [mu_sigma_c(1,n), mu_sigma_c(2,n)] = mybtcmeanstd(block, 6, 5);
    btc = mybtcthreshold(block, mu_sigma_c(1,n));
    binary_c(:,n) = btc;
end
binary_c = double(col2im(binary_c, [4 4], size(img_gray), 'distinct'));

figure('NumberTitle', 'off', 'Name', '1(e)');
subplot(221); imshow(img_gray); title('Original');
subplot(222); imshow(binary_a); title('B1=2, B2=1');
subplot(223); imshow(binary_b); title('B1=3, B2=4');
subplot(224); imshow(binary_b); title('B1=6, B2=5');

%% 1. Block Truncation Coding (BTC) (f)

% Compute BTC blocks
decode_a = im2col(binary_a, [4 4], 'distinct');
for n = 1:size(blocks,2)
    block = decode_a(:,n);
    decode_a(:,n) = mybtcdecode(block, mu_sigma_a(1,n), mu_sigma_a(2,n));
end
decode_a = uint8(col2im(decode_a, [4 4], size(img_gray), 'distinct'));

decode_b = im2col(binary_b, [4 4], 'distinct');
for n = 1:size(blocks,2)
    block = decode_b(:,n);
    decode_b(:,n) = mybtcdecode(block, mu_sigma_b(1,n), mu_sigma_b(2,n));
end
decode_b = uint8(col2im(decode_b, [4 4], size(img_gray), 'distinct'));

decode_c = im2col(binary_c, [4 4], 'distinct');
for n = 1:size(blocks,2)
    block = decode_c(:,n);
    decode_c(:,n) = mybtcdecode(block, mu_sigma_c(1,n), mu_sigma_c(2,n));
end
decode_c = uint8(col2im(decode_c, [4 4], size(img_gray), 'distinct'));

figure('NumberTitle', 'off', 'Name', '1(f)');
subplot(221); imshow(img_gray); title('Original');
subplot(222); imshow(decode_a); title('B1=2, B2=1');
subplot(223); imshow(decode_b); title('B1=3, B2=4');
subplot(224); imshow(decode_c); title('B1=6, B2=5');
