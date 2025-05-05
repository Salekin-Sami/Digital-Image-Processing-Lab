clc; clear; close all;

I = imread('line.jpg');
gray_image = double(rgb2gray(I));  % Convert to grayscale and double

% Define Sobel kernel manually for horizontal edge detection
sobel_h = [1 2 1; 0 0 0; -1 -2 -1];

% Get image size
[rows, cols] = size(gray_image);
line_detected_image = zeros(rows, cols);

% Apply convolution manually (skip borders)
for i = 2:rows-1
    for j = 2:cols-1
        region = gray_image(i-1:i+1, j-1:j+1);
        value = sum(sum(region .* sobel_h));
        line_detected_image(i,j) = abs(value);  % take magnitude
    end
end

% Thresholding
binary_lines = line_detected_image > 30;

% Display result
subplot(1,2,1); imshow(uint8(gray_image)); title('Gray image');
subplot(1,2,2);imshow(binary_lines, []); title('Horizontal Line Detection (Manual)');
