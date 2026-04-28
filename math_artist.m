% =========================================================================
% Script Name: math_artist.m
% Description: Generates an artificial, purely mathematical RGB image 
%              and visualizes the mathematical topography of each channel.
% Author: Antigravity (Görüntü İşleme ve Matlab/Octave Uzmanı)
% Compatibility: MATLAB & GNU Octave
% =========================================================================

% 1. Grid Kurulumu (1000x1000 çözünürlük)
% Vektörize işlemler için meshgrid kullanıyoruz.
N = 1000;
x = linspace(-pi, pi, N);
y = linspace(-pi, pi, N);
[X, Y] = meshgrid(x, y);

% Kutupsal koordinatlara dönüştürme (Estetik fonksiyonlar için)
R = sqrt(X.^2 + Y.^2);     % Yarıçap (Merkeze uzaklık)
Theta = atan2(Y, X);       % Açı (Radyan cinsinden)

% 2. Kanallar için Matematiksel Fonksiyonların Tanımlanması
% Her kanal tamamen vektörize olarak (for döngüsü olmadan) hesaplanır.

% Kırmızı Kanal (R): Sarmal dalgalar ve yüksek frekanslı girişimler.
% sin(3*R + 5*Theta): 5 kollu sarmal yapısı
% cos(X.^2 + Y.^2): Merkezden dışa doğru sıklaşan halkalar
R_channel = sin(3 * R + 5 * Theta) .* cos(X.^2 + Y.^2) + exp(-0.1 * R);

% Yeşil Kanal (G): Damalı periyodik yapı ile merkezcil dalgaların karışımı.
% sin(4*X).*cos(4*Y): Kartezyen ızgara/kare dokusu
% sin(10*R): Keskin ve sık dairesel dalgalar
G_channel = (sin(4 * X) .* cos(4 * Y)) .* exp(-0.2 * R) + 0.5 * sin(10 * R);

% Mavi Kanal (B): Merkezde parlayan ve kenarlara doğru karmaşıklaşan girdaplar.
% exp(-0.5 * R.^2): Merkezi parlama noktası (Gaussian)
% sin(7 * Theta + R.^2): Yarıçapla birlikte dönüş hızı artan girdaplar
B_channel = exp(-0.5 * R.^2) + 0.5 * sin(7 * Theta + R.^2);

% 3. Normalizasyon İşlemi
% Herhangi bir matrisi minimum 0, maksimum 1 olacak şekilde map eden anonim fonksiyon
normalize = @(Z) (Z - min(Z(:))) ./ (max(Z(:)) - min(Z(:)));

R_norm = normalize(R_channel);
G_norm = normalize(G_channel);
B_norm = normalize(B_channel);

% 4. RGB Görüntünün Birleştirilmesi
% 3D bir matris (RGB formatı) elde etmek için 3 matrisi 3. boyutta birleştiriyoruz
RGB_img = cat(3, R_norm, G_norm, B_norm);

% 5. Görselleştirme
% Ana figürü oluştur ve boyutlandır (Geniş ekran uyumlu)
fig = figure('Name', 'MathArtist: Matematiksel Sanat', 'Position', [100, 100, 1200, 600]);

% Sol Taraf: Birleştirilmiş RGB Görüntü
% 3 satır 2 sütunluk grid'de 1, 3, 5 numaralı alanları (sol sütunu) kaplar
subplot(3, 2, [1, 3, 5]);
% Octave uyumluluğu için imshow(RGB_img) veya image komutu kullanılabilir
% image komutu Octave'da Image Processing paketi olmadan daha güvenlidir
image(X(1,:), Y(:,1), RGB_img);
axis image off; % Eksenleri ve oranları düzelt
title('Tamamen Matematiksel RGB Görüntü', 'FontSize', 16, 'FontWeight', 'bold');

% Sağ Taraf: Kanalların 3D Matematiksel Topografyaları
% Performans için 1000x1000'lik yüzeyi downsample (alt örnekleme) ediyoruz (Örn: 10'da 1).
% Tüm noktaları çizmek aşırı bellek ve GPU yükü yaratır.
step = 10;
Xd = X(1:step:end, 1:step:end);
Yd = Y(1:step:end, 1:step:end);
R_down = R_norm(1:step:end, 1:step:end);
G_down = G_norm(1:step:end, 1:step:end);
B_down = B_norm(1:step:end, 1:step:end);

% Sağ Üst: Kırmızı Kanal
subplot(3, 2, 2);
surf(Xd, Yd, R_down, 'EdgeColor', 'none');
title('Kırmızı (R) Topografyası', 'Color', [0.8 0 0], 'FontWeight', 'bold');
colormap(gca, hot); % Kırmızıya uygun bir colormap
view(45, 45); 
axis tight off;

% Sağ Orta: Yeşil Kanal
subplot(3, 2, 4);
surf(Xd, Yd, G_down, 'EdgeColor', 'none');
title('Yeşil (G) Topografyası', 'Color', [0 0.6 0], 'FontWeight', 'bold');
colormap(gca, summer); % Yeşile uygun bir colormap
view(45, 45);
axis tight off;

% Sağ Alt: Mavi Kanal
subplot(3, 2, 6);
surf(Xd, Yd, B_down, 'EdgeColor', 'none');
title('Mavi (B) Topografyası', 'Color', [0 0 0.8], 'FontWeight', 'bold');
colormap(gca, winter); % Maviye uygun bir colormap
view(45, 45);
axis tight off;

% Işıklandırma (Daha estetik bir 3D görünüm için)
shading interp;
camlight left;
lighting gouraud;
