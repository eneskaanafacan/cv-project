N = 1000;
x = linspace(-pi, pi, N);
y = linspace(-pi, pi, N);
[X, Y] = meshgrid(x, y);

R = sqrt(X.^2 + Y.^2);
Theta = atan2(Y, X);

R_channel = sin(3 * R + 5 * Theta) .* cos(X.^2 + Y.^2) + exp(-0.1 * R);
G_channel = (sin(4 * X) .* cos(4 * Y)) .* exp(-0.2 * R) + 0.5 * sin(10 * R);
B_channel = exp(-0.5 * R.^2) + 0.5 * sin(7 * Theta + R.^2);

normalize = @(Z) (Z - min(Z(:))) ./ (max(Z(:)) - min(Z(:)));

R_norm = normalize(R_channel);
G_norm = normalize(G_channel);
B_norm = normalize(B_channel);

RGB_img = cat(3, R_norm, G_norm, B_norm);

fig = figure('Name', 'MathArtist', 'Position', [100, 100, 1200, 600]);

subplot(3, 2, [1, 3, 5]);
image(X(1,:), Y(:,1), RGB_img);
axis image off;
title('Matematiksel RGB Görüntü');

step = 10;
Xd = X(1:step:end, 1:step:end);
Yd = Y(1:step:end, 1:step:end);
R_down = R_norm(1:step:end, 1:step:end);
G_down = G_norm(1:step:end, 1:step:end);
B_down = B_norm(1:step:end, 1:step:end);

subplot(3, 2, 2);
surf(Xd, Yd, R_down, 'EdgeColor', 'none');
title('R Kanalı');
colormap(gca, hot);
view(45, 45); 
axis tight off;

subplot(3, 2, 4);
surf(Xd, Yd, G_down, 'EdgeColor', 'none');
title('G Kanalı');
colormap(gca, summer);
view(45, 45);
axis tight off;

subplot(3, 2, 6);
surf(Xd, Yd, B_down, 'EdgeColor', 'none');
title('B Kanalı');
colormap(gca, winter);
view(45, 45);
axis tight off;

shading interp;
camlight left;
lighting gouraud;
