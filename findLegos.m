% findLegos.m - Funktion zur Identifizierung von LEGO-Steinen in der Maske

function [cc, num] = findLegos(mask)
    % Bereinige die Maske mit Erosion
    se = strel('disk', 5);
    cleanMask = imerode(mask, se);
    %imshow(cleanMask), title('clean mask');
    
    % Finde und zähle die weißen verbundenen Komponenten
    cc = bwconncomp(cleanMask);
    num = cc.NumObjects;
    fprintf('Anzahl der LEGO-Steine: %d\n', num);
end
