clear();
%% 2. Discrete Cosine Transform (DCT) and JPEG (a)
% Read in grayscale image
img_gray = rgb2gray(imread('img/got.jpg'));

% Perform DCT on each non-overlapping 8x8 block
T = dctmtx(8);
dct = @(x) T*x.data*T';
img_dct = blockproc(double(img_gray), [8 8], dct);

% Show images side-by-side
figure('NumberTitle', 'off', 'Name', '2(a)');
subplot(121); imshow(img_gray); title('Original');
subplot(122); imshow(img_dct); title('DCT');

%% 2. Discrete Cosine Transform (DCT) and JPEG (b)
Q = [16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

% Obtain quantized result
Q_matrix = repmat(Q, 170, 255);
img_quantized = img_dct ./ Q_matrix;
img_quantized = round(img_quantized);

% Obtain lossy DCT image
img_lossy = img_quantized.*Q_matrix;
img_lossy = round(img_lossy);

% Calculate compression ratios
n_pixels = length(img_dct(:));
CR_quantized = nnz(img_quantized)/n_pixels;
CR_lossy = nnz(img_lossy)/n_pixels;

% Show images
figure('NumberTitle', 'off', 'Name', '2(b)');
subplot(121); imshow(img_quantized); title('Quantized Image');
subplot(122), imshow(img_lossy), title('Lossy DCT Image');

%% 2. Discrete Cosine Transform (DCT) and JPEG (c)
% Perform inverse DCT on each non-overlapping 8x8 block
invdct = @(y) T'*y.data*T;
img_reconst = blockproc(double(img_lossy), [8 8], invdct);

% Compute absolute difference between original and reconstructed images
abs_diff = imabsdiff(double(img_gray), img_reconst);

% Show images
figure('NumberTitle', 'off', 'Name', '2(c)');
subplot(121), imshow(uint8(img_reconst)), title('Reconstructed Image');

subplot(122), imshow(uint8(abs_diff)), title('Absolute Difference Image');
