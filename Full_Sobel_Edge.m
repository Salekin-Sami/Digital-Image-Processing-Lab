clc; clear; close all;

% Load and preprocess image
img = double(rgb2gray(imread("line.jpg")));
[r, c] = size(img);

% Define Sobel kernels
sobel_x = [-1 0 1; -2 0 2; -1 0 1];   % Vertical edges
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];   % Horizontal edges

% Initialize gradient magnitude image
edge_mag = zeros(r, c);

% Apply both filters manually
for i = 2:r-1
    for j = 2:c-1
        region = img(i-1:i+1, j-1:j+1);
        Gx = sum(sum(region .* sobel_x));
        Gy = sum(sum(region .* sobel_y));
        edge_mag(i, j) = sqrt(Gx^2 + Gy^2);  % Gradient magnitude
    end
end

% Threshold the magnitude to get binary edge map
threshold = 50;  % Adjust as needed
binary_edges = edge_mag > threshold;

% Show results
figure;
subplot(1,2,1); imshow(uint8(img)); title('Original Image');
subplot(1,2,2); imshow(binary_edges); title('Sobel Edge Detection (Manual)');
