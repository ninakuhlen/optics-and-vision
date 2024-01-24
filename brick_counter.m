img_rgb = imread(".\img_duplo.png"); % Liest das RGB-Bild von der Festplatte
img_hsv = rgb2hsv(img_rgb);
% img_bw = rgb2gray(img_rgb); % Konvertiert das RGB-Bild in ein Graustufenbild
% img_binarized = imbinarize(img_bw);

% HSV-Kanäle extrahieren
hue = img_hsv(:,:,1);        % Hue-Kanal
saturation = img_hsv(:,:,2); % Saturation-Kanal
value = img_hsv(:,:,3);      % Value-Kanal

% Schwellwerte definieren
saturationThreshold = 0.3;
valueThreshold = 0.2; 

% Maske erstellen
mask = (saturation > saturationThreshold) & (value > valueThreshold);

% Anwenden der Maske auf das Originalbild
% Nur Pixel, die der Maske entsprechen, bleiben unverändert und die, die
% nicht der Maske entsprechen werden schwarz, also 0
img_filter = img_rgb;

img_filter(~mask) = 0; % Für den roten Kanal
img_filter(~mask, :, 2) = 0; % Für den grünen Kanal
img_filter(~mask, :, 3) = 0; % Für den blauen Kanal

% jetzt die Nubsis entfernen
eroded_mask = bwareaopen(~mask, 100);

% Anwenden der bereinigten Maske auf das Originalbild
img_filter_cleaned = img_rgb;
img_filter_cleaned(repmat(eroded_mask, [1, 1, 3])) = 0;

% Bereinigte Maske auf das Originalbild anwenden
% img_filter_cleaned = img_rgb;
% img_filter_cleaned(~eroded_mask) = 0; % Für den roten Kanal
% img_filter_cleaned(~eroded_mask, :, 2) = 0; % Für den grünen Kanal
% img_filter_cleaned(~eroded_mask, :, 3) = 0; % Für den blauen Kanal

% --- imshow --- %

figure, imshow(img_rgb), title('normal') % Zeigt das Original-RGB-Bild an
figure, imshow(mask), title('mask') % Zeigt die ursprüngliche Maske an
figure, imshow(eroded_mask), title('eroded') % Zeigt die bereinigte Maske an
figure, imshow(img_filter_cleaned), title('cleaned filtered') % Zeigt das gereinigte Filterbild an