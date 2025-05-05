clc;        % Clears the command window
clear;      % Clears all variables from the workspace
close all;  % Closes all figure windows

a = double(imread("image1.jpg"));
b = double(imread("image2.jpg"));


a = imresize(a, [2000, 2000]);
b = imresize(b, [2000, 2000]);

figure;
subplot(1,2,1), imshow(uint8(a)), title('1st image');
subplot(1,2,2), imshow(uint8(b)), title('2nd image');

sumImage  = a + b;
diffImage = a - b;

sumImage  = uint8(min(sumImage, 255));
diffImage = uint8(max(diffImage, 0));

figure;

subplot(1,2,1), imshow(sumImage), title('Addition');
subplot(1,2,2), imshow(diffImage), title('Subtraction');


