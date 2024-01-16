[img_rgb, map]  = imread("C:\Users\serge\Documents\MATLAB\Screenshot 2024-01-03 113632.png"); % Liest das RGB-Bild von der Festplatte

masked = createAllColorsMask(img_rgb);

img_bw = masked; 

%% Defnition des Patternselements
se = strel('disk', 5); % Erstellt ein strukturelles Element für die Dilatation (hier: eine Linie)

%% erodieren, um Kleineigkeiten zu beseitigen
img_eroded = imerode(img_bw, se);

img_cleaned = bwareaopen(img_bw,5);

img_dilated = imdilate(img_cleaned, se); % Wendet die Dilatation auf das binäre Bild an

img_edge = edge(img_dilated); % Findet Kanten im black/white Bild

CC = bwconncomp(img_edge);

connectedAreasRegionRpoperties  = regionprops(CC, {'area', 'centroid'});

centroids = [connectedAreasRegionRpoperties.Centroid];

RGBresult = 255 * repmat(uint8(img_edge), 1, 1, 3); 

j = 0;

RGBresult = RGBresult + img_rgb;

for i = 1:2:length(centroids)
        
    j = j + 1;
       
    x = centroids(1, i);
       
    y = centroids(1, i+1);
       
    P = impixel(img_rgb,x,y)'/255;
        
    color_name = rgb2name(P);
        
    RGBresult = insertText( RGBresult , [x y] , j + ":" + color_name,FontSize=18,TextBoxColor=[1 1 1], ...
            BoxOpacity=0.4,TextColor="white" );

end

Titel = "Die Anzahl der Objekte: " + length(centroids)/2;

RGBresult = insertText( RGBresult , [10 10] , Titel, FontSize=18,TextBoxColor=[20 20 20]);

imshow(RGBresult)