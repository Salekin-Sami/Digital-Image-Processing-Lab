clc; clear; close all;

%% Part A: Log Transformation
img = imread('image1.jpg');
img_gray = rgb2gray(img);

c = 1; % Constant for log transformation
img_log = c * log(1 + double(img_gray));

% Normalize to range [0, 1]
img_log = (img_log - min(img_log(:))) / (max(img_log(:)) - min(img_log(:)));

% Display images
figure;
subplot(1,2,1); imshow(img_gray); title('Original Grayscale');
subplot(1,2,2); imshow(img_log); title('Log Transformed Image');

%% Part B: Intensity Mapping Visualization
% Prepare original intensities (0 to 255)
intensity_in = 0:255;
% Apply log transformation to each intensity
intensity_out = c * log(1 + double(intensity_in));
% Normalize output to [0, 1]
intensity_out = (intensity_out - min(intensity_out)) / (max(intensity_out) - min(intensity_out));

% Plot input vs output intensities
figure;
plot(intensity_in, intensity_out, 'LineWidth', 2);
xlabel('Original Intensity');
ylabel('Transformed Intensity');
title('Log Transformation Mapping');
grid on;
