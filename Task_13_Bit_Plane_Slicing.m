clc; clear; close all;
img = imread('image1.jpg');       
img = rgb2gray(img);             
img = imresize(img, [256 256]);  

% Show all bit planes in 2x4 grid
figure('Name','Bit Plane Slicing');
for i = 1:8
    % Manual bit extraction
    plane = mod(floor(double(img) / 2^(8-i)), 2);
    subplot(2, 4, i);
    imshow(logical(plane));  % Show the i-th bit plane
    title(['Bit Plane ', num2str(8-i)]);  % Title for the bit plane
end

% Initialize restored image
restored_img = zeros(size(img));

% Number of top bit planes to use for restoration (e.g., 8+7+6)
bit_planes_to_use = 5;  
for i = 1:bit_planes_to_use
    % Manual bit extraction
    plane = mod(floor(double(img) / 2^(8-i)), 2);
    % Add the selected bit plane to the restored image
    restored_img = restored_img + plane * 2^(8-i);
end

% Show original and restored image
figure('Name','Original and Restored Image');
subplot(1,3,1);
imshow(img);
title('Original Image');

% Show restored image using top N bit planes
subplot(1,3,2);
imshow(uint8(restored_img));
title(['Restored using top ', num2str(bit_planes_to_use), ' bit-planes']);

% Show restored image using all 8 bit planes 
all_planes_img = zeros(size(img));
for i = 1:8
    plane = mod(floor(double(img) / 2^(8-i)), 2);
    all_planes_img = all_planes_img + plane * 2^(8-i);
end
subplot(1,3,3);
imshow(uint8(all_planes_img));
title('Restored using all 8 bit-planes');
