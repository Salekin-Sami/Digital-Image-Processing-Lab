clc;
clear;
close all;

a = imread('image1.jpg');

b = 255 - a;

subplot(1,2,1), imshow(a), title('Original Image');
subplot(1,2,2), imshow(b), title('Negative Image');
