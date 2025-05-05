clc; clear; close all;

img = double(rgb2gray(imread('image1.jpg')));
[rows, cols] = size(img); L = 256;

% Histogram and PDF
hist = zeros(1, L);

for r = 1:rows
    for c = 1:cols
        val = img(r, c);
        hist(val + 1) = hist(val + 1) + 1;
    end
end
pdf = hist / (rows * cols);

% CDF without cumsum
cdf = zeros(1, L); cdf(1) = pdf(1);
for i = 2:L, cdf(i) = cdf(i-1) + pdf(i); end

% Equalize image
eq_img = uint8(round(cdf(img + 1) * (L - 1)));

% Equalized histogram
hist_eq = zeros(1, 256);
for r = 1:size(eq_img, 1)
    for c = 1:size(eq_img, 2)
        value = eq_img(r, c);
        hist_eq(value + 1) = hist_eq(value + 1) + 1;
    end
end

% Display
y_max = max([hist hist_eq]);
figure;
subplot(2,2,1); imshow(uint8(img)); title('Original Image');
subplot(2,2,2); bar(0:255, hist, 'k'); title('Original Histogram'); xlim([0 255]); ylim([0 y_max]);
subplot(2,2,3); imshow(eq_img); title('Equalized Image');
subplot(2,2,4); bar(0:255, hist_eq, 'k'); title('Equalized Histogram'); xlim([0 255]); ylim([0 y_max]);
