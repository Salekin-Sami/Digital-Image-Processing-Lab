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

% Manual image sharpening (unsharp masking)
img_double = double(img_gray);
amount = 1.5; % Sharpening amount
% Create sharpened image: original + (original - blurred) * amount
sharpImage = img_double + (img_double - double(img_smooth)) * amount;
% Clip values to valid range
sharpImage = max(0, min(255, sharpImage));
sharpImage = uint8(sharpImage);

imshow(sharpImage), title('Sharpened Image');