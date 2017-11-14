%% Apply DCT to Block
image = rgb2gray(imread('img/got.jpg'));
T = dctmtx(8);
dct = @(x) T*x.data*T';
B = blockproc(double(image), [8 8], dct);
figure, imshow(B, []), title('DCT Applied to Blocks');
figure, imshow(image), title('Original Image');

%% Image Quantization and Lossy Image
Q = [16 11 10 16 24 40 51 61; ...
    12 12 14 19 26 58 60 55;  ...
    14 13 16 24 40 57 69 56;  ...
    14 17 22 29 51 87 80 62;  ...
    18 22 37 56 68 109 103 77; ...
    24 35 55 64 81 104 113 92; ...
    49 64 78 87 103 121 120 101; ...
    72 92 95 98 112 100 103 99];

N = repmat(Q, 170, 255);
A = B ./ N;
A = round(A);
subplot(1, 2, 1), imshow(A), title('Quantized Image');

s = 2774400;
non = nnz(A);
CR = non/s; %Compression Ratio for Quantized Image

Z = A.*N;
Z = round(Z);

subplot(1, 2, 2), imshow(Z), title('Lossy DCT Image');
non2 = nnz(Z);
CR2 = non2/s; %Compression Ratio for Lossy Image

%% Inverse DCT 
invdct = @(y) T'*y.data*T;
R = blockproc(double(Z), [8 8], invdct);


abs_diff = imabsdiff(double(image), R);

subplot(1, 2, 1), imshow(image), title('Original Image');
subplot(1, 2, 2), imshow(R, []), title('Reconstructed Image');


