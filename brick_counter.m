img_rgb = imread(".\img_duplo.png"); % Liest das RGB-Bild von der Festplatte
img_hsv = rgb2hsv(img_rgb);
img_bw = rgb2gray(img_rgb); % Konvertiert das RGB-Bild in ein Graustufenbild
img_binarized = imbinarize(img_bw);

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

 figure, imshow(img_rgb), title('normal') % Zeigt das Original-RGB-Bild in einem neuen Fenster an
% figure, imshow(img_bw), title('bw') % Zeigt das Graustufenbild in einem neuen Fenster an
% figure, imshow(img_binarized), title('binarized') % Zeigt das Graustufenbild in einem neuen Fenster an
imshow(mask), title('mask')
% figure, imshow(img_filter), title('filtered') % Zeigt das FIlterbild in einem neuen Fenster an
