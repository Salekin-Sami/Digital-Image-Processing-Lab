clc; clear; close all;

I = imread('image1.jpg');
threshold = 128;
grayImage = rgb2gray(I);
binaryImage = grayImage > threshold;

imshow(binaryImage), title('Binary Image');

% | Threshold | Use this grayImage             |
% | --------- | ------------------------------ |
% | `> 128`   | `grayImage = rgb2gray(I);`     |
% | `> 0.5`   | `grayImage = rgb2gray(I)/255;` |

% if rgb to gray need to be implemented manually check previous code