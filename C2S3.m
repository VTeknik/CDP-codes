clear all;
clc;
close all;
format long;

M0 = 4*pi* 1E-7; % permeability constant 
%  nx = 514; ny = 34460 ;nz =27694; H = 34467; T = 44213;
% C = 15;
beta = 3;
W = 2000; %  two times of cell size (meter)

filename = 'W60B3Op80Bw12CS1_susc.XYZ';
C2S = load (filename); % Import aeromag's XYZ format  data 
C = C2S(:,7); % C prameter
T = C2S(:,12); % Total geomagnetic field in T
inc = C2S(:,11); % Inclination
dec = C2S(:,10); % Declination

H = T .* cos(deg2rad(inc));
nx = H .* cos(deg2rad(dec)); 
ny = H .* sin(deg2rad(dec)); 
nz = H .* sin(deg2rad(inc));



 T2 = sqrt((nx.^2)+(ny.^2)+(nz.^2));
 T3 = T- T2;



teta = 0:pi/100:2*pi;

for j =1: length(T) 
f = log( ((M0./T(j)).^2) .* ( (nz(j).^2) + ((H(j).^2) * (cos(teta)).^2) ).^2);

int_p = trapz(teta,f);
% int_p = integral(log( ((M0/T)^2) * ( (nz^2) + (H^2) * (cos(teta))^2 )^2) , 0, 2*pi);


int_p = int_p / (2*pi);

ln_cs = C(j) - int_p;
cs = exp(ln_cs);

K =sqrt( 3 * (((2*pi)/W)^2));
Sus = (sqrt( (cs .*((3*((2*pi)^2))^(-beta/2)) ) / (W ^(-beta+1)) ) ) * exp( (2i*K));
% Sus2 = abs(Sus);
Sus2(j) = abs(Sus) * 1E-9;
end

 Susc= [C2S Sus2'];
 
save (filename, 'Susc', '-ASCII')
 
 figure(1)
  plot (C ,Sus2, 'O')
   figure(2)
nbins = 500;
hist(Sus2,nbins)
  
  