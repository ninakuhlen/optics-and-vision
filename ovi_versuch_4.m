path_to_image = "C:\Users\serge\Documents\MATLAB\Screenshot 2024-01-03 113632.png";

[img_rgb, map]  = imread(path_to_image); % Liest das RGB-Bild von der Festplatte

masked = createAllColorsMask(img_rgb);
mask3 = cat(3, masked, masked, masked);
mask3 = ~mask3;
img_rgb_m = img_rgb;
img_rgb_m(mask3) = 0;



img_bw = masked; 

%% Defnition des Patternselements
se = strel('disk', 5); % Erstellt ein strukturelles Element für die Dilatation (hier: eine Linie)

%% erodieren, um Kleineigkeiten zu beseitigen
img_eroded = imerode(img_bw, se);

img_cleaned = bwareaopen(img_bw,5);

img_dilated = imdilate(img_cleaned, se); % Wendet die Dilatation auf das binäre Bild an

img_edge = edge(img_dilated); % Findet Kanten im black/white Bild

CC = bwconncomp(img_edge);

connectedAreasRegionRpoperties  = regionprops(CC, {'Centroid', 'Orientation', 'BoundingBox','MajorAxisLength','MinorAxisLength'});

centroids = [connectedAreasRegionRpoperties.Centroid];

orientations = [connectedAreasRegionRpoperties.Orientation];

boundingBoxes = [connectedAreasRegionRpoperties.BoundingBox];

RGBresult = 255 * repmat(uint8(img_edge), 1, 1, 3); 

j = 0;

RGBresult = RGBresult + img_rgb;


stoneImages = cell(1,length(connectedAreasRegionRpoperties));

shapes = strings(1,length(connectedAreasRegionRpoperties));

colors = strings(1,length(connectedAreasRegionRpoperties));

index_kleiner_klotz = 1;

index_grosser_klotz = 1;

for i = 1:length(connectedAreasRegionRpoperties)
    
     if (connectedAreasRegionRpoperties(i).MajorAxisLength / connectedAreasRegionRpoperties(i).MinorAxisLength) < 1.25

        shape = "Kleiner Klotz " + index_kleiner_klotz;

        index_kleiner_klotz = index_kleiner_klotz + 1;

    else
        shape = "Grosser Klotz " + index_grosser_klotz;

        index_grosser_klotz = index_grosser_klotz + 1;

    end


    shapes(i) = shape;

    y = ceil(connectedAreasRegionRpoperties(i).Centroid(1, 1) );
       
    x = ceil(connectedAreasRegionRpoperties(i).Centroid(1, 2) );
       
    hue_image = rgb2hsv(img_rgb);

   hsv_color_name = hsv2name(squeeze(hue_image(x, y, :)));

   colors(i) = hsv_color_name;

    croppedImage = imcrop(img_rgb_m, [connectedAreasRegionRpoperties(i).BoundingBox(1),...
        connectedAreasRegionRpoperties(i).BoundingBox(2),...
        connectedAreasRegionRpoperties(i).BoundingBox(3),...
        connectedAreasRegionRpoperties(i).BoundingBox(4)]);
    
    maskedCropped = createAllColorsMask(croppedImage);

    stoneImages{i} = croppedImage;
    
end

fig = figure(); 

tlo = tiledlayout('flow');

for i = 1:numel(stoneImages)

    ax = nexttile(tlo); 

    imshow(stoneImages{i},'Parent',ax);

    title(['Image ', shapes(i), strcat("(", colors(i),")")]);

end