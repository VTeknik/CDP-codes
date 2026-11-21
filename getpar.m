
function [win_l,overlap,beta,cs,dcs,per,kbeta] = getpar
% This function gets the needed parameters
win_l= input('input window Length (in KM):  '); % window is square with length 'win_l'
O_P = input('input percent of win overlap (0%-100%):  ');
overlap = O_P*win_l/100; % define overlap percentage
beta = input('input calculation beta:  '); % Beta(Fractal prameter) is considered 
kbeta = input('input kaiser beta  '); % Keiser window beta parameter for more information see Matlab help
save beta beta % saves for later using in the main program
save kbeta
cs = input('input cell size(km)  '); % grid cell size
dcs = cs/111; %cell size in degree
per = 90/100; % min percent of number of data points that must exist at each win
end