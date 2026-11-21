
function showresults(topout,dcs)
% =======================Show final results===============================
figure('units','normalized','outerposition',[0 0 1 1])
drawnow;
hold on
axis equal
[LONG,LAT,TOP] = griding(topout(:,3),topout(:,4),topout(:,5),dcs);
contourf(LONG,LAT,TOP);
% read shapefile 
shp = shaperead('Ostan.shp');
%extract Easting/Northing or Lat/long
x1 = extractfield(shp,'X');
y1 = extractfield(shp,'Y');
x1=x1';
y1=y1';
%show ascci data in map
mapshow(x1,y1)
end