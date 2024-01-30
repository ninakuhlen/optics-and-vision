% findLegos.m - Funktion zur Identifizierung von LEGO-Steinen in der Maske

function [cc, num] = findLegos(mask)
    % Bereinige die Maske mit Erosion
    se = strel('disk', 5);
    cleanMask = imerode(mask, se);
    
    % Finde verbundene Komponenten
    cc = bwconncomp(cleanMask);
    num = cc.NumObjects;
end