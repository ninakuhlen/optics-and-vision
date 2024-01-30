% main.m - Hauptskript zur Analyse der LEGO-Steine

% Bereinige die Umgebung und schließe alle offenen Figuren
clc;
clearvars;
close all;

% Lade das Bild von der Festplatte
img_rgb = imread(".\img_duplo.png");

% Konvertiere das RGB-Bild in den HSV-Farbraum und extrahiere die Maske
[mask, hue] = createMask(img_rgb);

% Bereinige die Maske und finde die LEGO-Steine
[cc, num] = findLegos(mask);

% Identifiziere die Farben und Größen der LEGO-Steine
[stoneColors, stoneSizes] = identifyColorsAndSizes(hue, cc);

% Erzeuge und zeige Bilder mit beschrifteten LEGO-Steinen
showLabeledLegos(img_rgb, cc, stoneColors, stoneSizes);
