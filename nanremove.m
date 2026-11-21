function[MAG_G] = nanremove(MAG_G)
mask = ~isnan(MAG_G);
Not_Nan_MAG_G = MAG_G(mask);
Mean_Not_Nan_MAG_G = mean(Not_Nan_MAG_G);
MAG_G(isnan(MAG_G)) = [Mean_Not_Nan_MAG_G];
