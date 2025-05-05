clc; clear; close all;

img = imread('zoom.jpg');

scale = 2.5;
[rows, cols, ch] = size(img);
zoomed_image = zeros(scale*rows, scale*cols, ch, 'like', img);

for r = 1:scale*rows
    for c = 1:scale*cols
        zoomed_image(r, c, :) = img(ceil(r/scale), ceil(c/scale), :);
    end
end

scale = 0.5;
[rows, cols, ch] = size(img);
new_rows = floor(rows * scale);
new_cols = floor(cols * scale);
shrunk_image = zeros(new_rows, new_cols, ch, 'like', img);

for r = 1:new_rows
    for c = 1:new_cols
        shrunk_image(r, c, :) = img(ceil(r / scale), ceil(c / scale), :);
    end
end

zoomed_image_builtin = imresize(img, 2.5); % Zoom by factor of 2
shrunk_image_builtin = imresize(img, 0.5); % Shrink by factor of 0.5

figure;
subplot(2,2,1); imshow(zoomed_image_builtin); title('Zoomed Image builtin');
subplot(2,2,2); imshow(shrunk_image_builtin); title('Shrunk Image builtin');
subplot(2,2,3); imshow(zoomed_image); title('Zoomed Image');
subplot(2,2,4); imshow(shrunk_image); title('Shrunk Image');