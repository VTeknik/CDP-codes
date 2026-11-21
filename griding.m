
% This function grids input data in equal cell sizes
function  [XI,YI,ZI]=griding(x,y,mag,cells)

xi = min(x):cells:max(x);
yi = min(y):cells:max(y);

[XI,YI] = meshgrid(xi,yi);

ZI = griddata(x,y,mag,XI,YI,'cubic');


