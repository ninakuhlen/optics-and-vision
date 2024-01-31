classdef ColorFilter
    properties
        OriginalImage   % Speichert das ursprüngliche Bild
        HsvImage        % Speichert das Bild im HSV-Farbraum
        FilteredMask    % Speichert die kombinierte Maske
        FilteredImage   % Speichert das gefilterte Bild
    end

    methods
        % Konstruktor
        function obj = ColorFilter(imagePath)
            obj.OriginalImage = imread(imagePath);
            obj.HsvImage = rgb2hsv(obj.OriginalImage);
            obj.FilteredMask = false(size(obj.OriginalImage, 1), size(obj.OriginalImage, 2));
        end

        % Methode zum Definieren des Farbbereichs und Erstellen der Maske
        function obj = addColorRange(obj, minHue, maxHue)
            hueMask = (obj.HsvImage(:,:,1) >= minHue) & (obj.HsvImage(:,:,1) <= maxHue);
            obj.FilteredMask = obj.FilteredMask | hueMask;
        end

        % Methode zum Anwenden der Maske
        function applyMask(obj)
            obj.FilteredImage = obj.OriginalImage;
            obj.FilteredImage(repmat(~obj.FilteredMask, [1 1 3])) = 0;
        end

        % Methode zum Anzeigen des Bildes
        function showImage(obj)
            imshow(obj.FilteredImage);
        end
    end
end
