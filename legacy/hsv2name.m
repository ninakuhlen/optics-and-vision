function name=hsv2name(x)

dims=size(x);

if numel(dims)>2 || ~any(dims==3)
    error('Input must be a 3x1 or 3xn array')
end

if any(x(:)<0 | x(:)>1)
    error('All elements of input array must be in the range 0 to 1')
end

H = x(1).*360;

if  H < 10
    name = "Rot";
elseif H < 40
    name = "Orange";
elseif H < 60
    name = "Gelb";
elseif H < 160
    name = "Grün";
elseif H < 180
    name = "Cyan";
elseif  H < 250
    name = "Blau";
elseif 350 <= H && H <= 360
    name = "Rot";
else
    name = "Unbekannt";
end


