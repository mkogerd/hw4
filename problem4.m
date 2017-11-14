clear();
%% 4. Image Quality (a)
% images/
%% 4. Image Quality (b)
% See attached spreadsheet
%% 4. Image Quality (c)
% See attached spreadsheet
%% 4. Image Quality (d)
% Read in images
img1 = imread('BRISQUE_release/testimage1.bmp');
img2 = imread('BRISQUE_release/testimage2.bmp');
% Show images side-by-side
figure('NumberTitle', 'off', 'Name', '2(a)');
subplot(121); imshow(img1); title('testimage1');
subplot(122); imshow(img2); title('testimage2');
% Calculate quality scores
qualityscore1 = brisquescore(img1);
qualityscore2 = brisquescore(img2);

%% 4. Image Quality (e)
qualityscores = zeros(48,1);
for i = 1:48
    img = imread(['images/img_' num2str(i) '.JPG']);
    qualityscores(i,1) = brisquescore(img);
end

%% 4. Image Quality (f)
% Get self-assigned quality scores
self_scores = [3 2 3 2 3 3 3 3 2 1 2 2 1 1 1 1 2 1 2 1 2 2 1 1 ...
               3 3 2 3 4 3 3 3 2 2 1 2 1 2 2 1 3 3 4 4 3 5 5 5]';
% Calculate LCC coefficients
[lcc_rho lcc_pval] = corr(self_scores, qualityscores, 'type', 'Pearson');
% Calculate SROCC coefficients
[sro_rho sro_pval] = corr(self_scores, qualityscores, 'type', 'Spearman');

