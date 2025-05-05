clc; clear; close all;

a = imread('image1.jpg');

if size(a,3) == 3
    img_gray = rgb2gray(a);
else
    img_gray = a;
end

hist = zeros(1, 256);  % Initialize histogram

[rows, cols] = size(img_gray);
for i = 1:rows
    for j = 1:cols
        intensity = img_gray(i, j);
        hist(intensity + 1) = hist(intensity + 1) + 1;
    end
end


hist_builtin = imhist(img_gray);

figure;
imshow(img_gray);

figure;
subplot(1,2,1);
bar(0:255, hist);
title('Manual Histogram');
xlabel('Gray Level'); ylabel('Count');

subplot(1,2,2);
bar(0:255, hist_builtin);
title('Built-in imhist');
xlabel('Gray Level'); ylabel('Count');