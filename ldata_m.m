function [x,y,mag,long,lat] = ldata_m
% load filename : here the file name is model_p
% loaded file inculdes coordinate and mag value coloumns
[beta_t,zt_t,dz_t,mcs] = model;% this function creats the model
load model_p; % Import aeromag's XYZ format Mag data
datain = model_p; % Replace loaded data in "datain".
mag = datain(:,3); % mag is Z column of XYZ format loaded 
x = datain(:,1); % unit is Km
y = datain(:,2); % unit is Km
long = datain(:,1); % for showing result in lat and long coordinate(unit Desimal degree)   
lat = datain(:,2); % for showing result in lat and long coordinate
clear datain; % clears unused varibles to free memory
clear model_p;
end