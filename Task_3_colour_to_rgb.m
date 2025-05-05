clc;
clear;
close all;

img = imread('image1.jpg');
img_gray = 0.2989 * img(:,:,1) + 0.5870 * img(:,:,2) + 0.1140 * img(:,:,3);

figure;
subplot(1,2,1); imshow(img);       title('Original Image');
subplot(1,2,2); imshow(img_gray);  title('Grayscale Image');