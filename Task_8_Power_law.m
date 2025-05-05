clc; clear; close all;

%% Part A - Power-Law Transformation

% Read image
img = imread('image1.jpg');

% Convert to grayscale
img_gray = rgb2gray(img);

% Apply power-law transformation
gamma = 2; % Adjust gamma here
img_normalized = double(img_gray) / 255;
img_corrected = img_normalized .^ gamma;
img_power = uint8(img_corrected * 255);

% Display images
figure;
subplot(1,2,1); imshow(img_gray); title('Original Gray Image');
subplot(1,2,2); imshow(img_power); title(['Power-Law Transformed (\gamma = ' num2str(gamma) ')']);

%% Part B - Plot Original vs. Transformed Intensity Mapping- Not necessary

% Plot how intensities change due to power-law
r = linspace(0, 1, 256);       % Input intensities (normalized)
s = r .^ gamma;                % Transformed intensities

figure;
plot(r * 255, s * 255, 'LineWidth', 2); grid on;
xlabel('Original Intensity'); ylabel('Transformed Intensity');
title(['Intensity Mapping Curve (Power-Law with \gamma = ' num2str(gamma) ')']);
xlim([0 255]); ylim([0 255]);
