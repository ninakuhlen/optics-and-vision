% createMask.m - Funktion zur Erstellung einer Maske aus dem RGB-Bild

function [mask, hue] = createMask(img_rgb)
    % Konvertiere das Bild in den HSV-Farbraum
    img_hsv = rgb2hsv(img_rgb);
    
    % Extrahiere die Hue-Komponente und skaliere auf 0-360 Grad
    hue = img_hsv(:,:,1) * 360;
    
    % Definiere Schwellwerte
    saturationThreshold = 0.3;
    valueThreshold = 0.2;
    
    % Erstelle die Maske
    saturation = img_hsv(:,:,2);
    value = img_hsv(:,:,3);
    mask = (saturation > saturationThreshold) & (value > valueThreshold);
    %imshow(mask), title('mask') % Zeigt die ursprüngliche Maske an

end
