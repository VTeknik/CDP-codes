function [x,y,mag,long,lat] = ldata
% load filename : here the file name is Rdata 
% loaded file inculdes coordinate and mag value coloumns
load ausmag2.XYZ; % Import aeromag's XYZ format Mag data: 
datain = ausmag2; % Replace loaded data in "datain".
mag = datain(:,3); % mag is Z column of XYZ format loaded 
x = datain(:,4); % unit is Km
y = datain(:,5); % unit is Km
long = datain(:,1); % for showing result in lat and long coordinate(unit Desimal degree)   
lat = datain(:,2); % for showing result in lat and long coordinate
clear datain; % clears unused varibles to free memory

end