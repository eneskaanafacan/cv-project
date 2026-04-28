N = 3;
border_size = 2;

if exist('RGB_img', 'var')
    I = RGB_img;
else
    try
        I = imread('peppers.png');
    catch
        [x_grid, y_grid] = meshgrid(1:500, 1:500);
        I = cat(3, sin(x_grid/20), cos(y_grid/20), mod(x_grid.*y_grid, 255)/255);
        I = (I+1)/2;
    end
end

[rows, cols, channels] = size(I);
min_dim = min(rows, cols);

start_row = floor((rows - min_dim) / 2) + 1;
start_col = floor((cols - min_dim) / 2) + 1;

I_square = I(start_row : start_row + min_dim - 1, ...
             start_col : start_col + min_dim - 1, :);

piece_size = floor(min_dim / N);
actual_dim = piece_size * N;
I_square = I_square(1:actual_dim, 1:actual_dim, :);

dist_array_r = repmat(piece_size, 1, N);
dist_array_c = repmat(piece_size, 1, N);
pieces = mat2cell(I_square, dist_array_r, dist_array_c, channels);

for r = 1:N
    for c = 1:N
        slice = pieces{r, c};
        slice(1:border_size, :, :) = 0;
        slice(end-border_size+1:end, :, :) = 0;
        slice(:, 1:border_size, :) = 0;
        slice(:, end-border_size+1:end, :) = 0;
        pieces{r, c} = slice;
    end
end

pieces_flat = pieces(:);
num_pieces = N * N;

idx_var1 = randperm(num_pieces);
idx_var2 = randperm(num_pieces);
idx_var3 = randperm(num_pieces);

puzzle1_cells = reshape(pieces_flat(idx_var1), N, N);
puzzle2_cells = reshape(pieces_flat(idx_var2), N, N);
puzzle3_cells = reshape(pieces_flat(idx_var3), N, N);

img_var1 = cell2mat(puzzle1_cells);
img_var2 = cell2mat(puzzle2_cells);
img_var3 = cell2mat(puzzle3_cells);

figure('Name', 'Orijinal Görüntü (Karelenmiş)');
if ismatrix(I_square) || ndims(I_square) == 3
    image(I_square);
else
    imshow(I_square);
end
axis image off;
title(['Orijinal Kırpılmış Görüntü (' num2str(actual_dim) 'x' num2str(actual_dim) ')']);

figure('Name', 'Bulmaca Varyasyonları', 'Position', [100, 100, 1500, 500]);

subplot(1, 3, 1);
image(img_var1);
axis image off;
title(['Varyasyon 1 (N = ' num2str(N) ')']);

subplot(1, 3, 2);
image(img_var2);
axis image off;
title(['Varyasyon 2 (N = ' num2str(N) ')']);

subplot(1, 3, 3);
image(img_var3);
axis image off;
title(['Varyasyon 3 (N = ' num2str(N) ')']);
