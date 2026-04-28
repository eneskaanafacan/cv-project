% =========================================================================
% Script Name: puzzle_generator.m
% Description: Kare bir RGB resmi merkezden kırparak NxN boyutunda 
%              rastgele karıştırılmış bulmaca varyasyonları oluşturur.
% Author: Antigravity (Görüntü İşleme ve Algoritma Uzmanı)
% Compatibility: MATLAB & GNU Octave
% =========================================================================

% 1. Kullanıcı Ayarları
N = 4; % Bulmaca grid boyutu (N=3 için 9 parça, N=4 için 16 parça)
border_size = 2; % Parçaların belli olması için eklenecek siyah çerçevenin kalınlığı (piksel)

% 2. Görüntüyü Okuma veya Yakalama
% Eğer bir önceki "math_artist" scripti çalıştırıldıysa workspace'deki
% RGB_img değişkenini kullan, yoksa dahili/sentetik bir resim yükle.
if exist('RGB_img', 'var')
    I = RGB_img;
    % Resim [0, 1] double formatındaysa 8-bit'e çevirmek görsel işlemeyi kolaylaştırabilir, 
    % ancak double olarak da bırakabiliriz. Orijinal formunu saklıyoruz.
else
    try
        I = imread('peppers.png'); % Matlab/Octave standart test görüntüsü
    catch
        % Görüntü paketi yoksa sentetik test matrisi oluştur
        [x_grid, y_grid] = meshgrid(1:500, 1:500);
        I = cat(3, sin(x_grid/20), cos(y_grid/20), mod(x_grid.*y_grid, 255)/255);
        I = (I+1)/2; 
    end
end

% 3. Kare Yapma (Merkezden Kırpma / Center Cropping)
[rows, cols, channels] = size(I);
min_dim = min(rows, cols);

% İşlemin tam merkezden yapılabilmesi için başlangıç noktalarını buluyoruz
start_row = floor((rows - min_dim) / 2) + 1;
start_col = floor((cols - min_dim) / 2) + 1;

% Orijinal resmi kusursuz bir kareye daralt
I_square = I(start_row : start_row + min_dim - 1, ...
             start_col : start_col + min_dim - 1, :);

% N x N'e bölünebilmesi için artık pikselleri atıyoruz
piece_size = floor(min_dim / N);
actual_dim = piece_size * N;
I_square = I_square(1:actual_dim, 1:actual_dim, :);

% 4. Parçalama İşlemi (Image Slicing)
% mat2cell: Görüntü matrisini hücre (cell array) dizisine çevirecek özel vektörize komut
dist_array_r = repmat(piece_size, 1, N); % [s s s...] matris satır dağılımı
dist_array_c = repmat(piece_size, 1, N); % [s s s...] matris sütun dağılımı
pieces = mat2cell(I_square, dist_array_r, dist_array_c, channels); % N x N boyutunda cell array

% Parçaların etrafına sınır (border) çizgi çekme
% N sayısı her zaman ufak olacağı için (3, 4 vb) ufak loop performansı etkilemez
for r = 1:N
    for c = 1:N
        slice = pieces{r, c};
        % Parçaların kenarlarını siyaha (0) boya
        slice(1:border_size, :, :) = 0; % Üst kenar
        slice(end-border_size+1:end, :, :) = 0; % Alt kenar
        slice(:, 1:border_size, :) = 0; % Sol kenar
        slice(:, end-border_size+1:end, :) = 0; % Sağ kenar
        pieces{r, c} = slice; 
    end
end

% 5. Rastgele Dağıtım (Shuffling)
pieces_flat = pieces(:); % NxN'lik matrisi N^2 uzunluğunda düz bir vektöre (sütun formatı) çevir
num_pieces = N * N;

% 3 farklı "randperm" sırası (indeks dizilimi) elde etme
idx_var1 = randperm(num_pieces);
idx_var2 = randperm(num_pieces);
idx_var3 = randperm(num_pieces);

% Düz haldeki cell alanını rastgele indekslerine göre çekip, geri N x N matris formuna bükmek
puzzle1_cells = reshape(pieces_flat(idx_var1), N, N);
puzzle2_cells = reshape(pieces_flat(idx_var2), N, N);
puzzle3_cells = reshape(pieces_flat(idx_var3), N, N);

% 6. Bulmacayı Birleştirme (Cell Array'i geri Matrise Dönüştürmek)
% cell2mat: Hücreleri tek parça bir imaj yapısına pürüzsüzce birleştirir
img_var1 = cell2mat(puzzle1_cells);
img_var2 = cell2mat(puzzle2_cells);
img_var3 = cell2mat(puzzle3_cells);

% 7. Görselleştirme (Visualization)
% Orijinal Kare Görüntü
figure('Name', 'Orijinal Görüntü (Karelenmiş)');
% Octave uyumluluğu gözetilerek alternatif çizim
if ismatrix(I_square) || ndims(I_square) == 3
    image(I_square); 
else 
    imshow(I_square); 
end
axis image off;
title(['Orijinal Kırpılmış Görüntü (' num2str(actual_dim) 'x' num2str(actual_dim) ')'], 'FontSize', 14);

% Bulmaca Varyasyonları
figure('Name', 'Bulmaca Varyasyonları', 'Position', [100, 100, 1500, 500]);

% Birinci Varyasyon
subplot(1, 3, 1);
image(img_var1);
axis image off;
title(['Varyasyon 1 (N = ' num2str(N) ')'], 'FontSize', 12, 'FontWeight', 'bold');

% İkinci Varyasyon
subplot(1, 3, 2);
image(img_var2);
axis image off;
title(['Varyasyon 2 (N = ' num2str(N) ')'], 'FontSize', 12, 'FontWeight', 'bold');

% Üçüncü Varyasyon
subplot(1, 3, 3);
image(img_var3);
axis image off;
title(['Varyasyon 3 (N = ' num2str(N) ')'], 'FontSize', 12, 'FontWeight', 'bold');
