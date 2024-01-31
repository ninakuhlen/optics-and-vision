% showLabeledLegos.m - Funktion zur Anzeige der LEGO-Steine mit Klassifizierung im Figurentitel

function showLabeledLegos(img_rgb, cc, stoneColors, stoneSizes)
    % Durchlaufe alle identifizierten LEGO-Steine
    for i = 1:length(stoneColors)
        box = regionprops(cc, 'BoundingBox');
        boundingBox = ceil(box(i).BoundingBox);
        stoneImage = imcrop(img_rgb, boundingBox);
        
        % Zeige das Bild des Steins in einer neuen Figur an
        figure;
        imshow(stoneImage);
        
        % Setze den Titel der Figur mit Nummer, Farbe und Größe des Steins
        title([stoneSizes{i} ' Klotz ' num2str(i) ' (' stoneColors{i} ')']);
    end
end
