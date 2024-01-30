% identifyColorsAndSizes.m - Funktion zur Identifizierung der Farbe und Größe der LEGO-Steine

function [stoneColors, stoneSizes] = identifyColorsAndSizes(hue, cc)
    % Definiere die Hue-Bereiche für die Farben
    hueRanges = [350, 10; 10, 40; 40, 60; 60, 160; 160, 180; 180, 250];
    colors = {'Rot', 'Orange', 'Gelb', 'Grün', 'Cyan', 'Blau'};
    
    % Arrays zum Speichern der Farben und Größen
    stoneColors = cell(cc.NumObjects, 1);
    stoneSizes = cell(cc.NumObjects, 1);
    
    % Durchlaufe alle gefundenen LEGO-Steine, um deren Farben und Größen zu identifizieren
    for i = 1:cc.NumObjects
        stonePixels = cc.PixelIdxList{i};
        averageHue = mean(hue(stonePixels));
        stoneColor = 'Unbekannt';
        
        % Bestimme die Farbe basierend auf dem durchschnittlichen Hue-Wert
        for j = 1:size(hueRanges, 1)
            lowerBound = hueRanges(j, 1);
            upperBound = hueRanges(j, 2);
            if (lowerBound > upperBound && (averageHue >= lowerBound || averageHue < upperBound)) || ...
               (averageHue >= lowerBound && averageHue < upperBound)
                stoneColor = colors{j};
                break;
            end
        end
        
        % Bestimme die Größe basierend auf der Fläche
        stoneArea = numel(stonePixels);
        if stoneArea > 10000 % Angenommener Schwellenwert für große Steine
            stoneSize = 'groß';
        else
            stoneSize = 'klein';
        end
        
        % Speichere die identifizierte Farbe und Größe
        stoneColors{i} = stoneColor;
        stoneSizes{i} = stoneSize;
    end
end
