clc; clear; close all;

% Load and prepare image
img = imread('smoothing.jpg');
img_gray = rgb2gray(img);

% Apply 3x3 average filter manually
[rows, cols] = size(img_gray);
img_smooth = zeros(rows, cols);
for i = 2:rows-1
    for j = 2:cols-1
        % Calculate average of 3x3 neighborhood
        window = img_gray(i-1:i+1, j-1:j+1);
        img_smooth(i,j) = sum(window(:))/9;
    end
end
img_smooth = uint8(img_smooth);

% Display result
figure;
subplot(1,2,1); imshow(img_gray); title('Original Image');
subplot(1,2,2);imshow(img_smooth); title('Smoothed Image');