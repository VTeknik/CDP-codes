
function [kx,ky,kz] = wavenumber_m(nx,ny,nz,lx,ly,lz)
   A=ones(1,nx);
   kx = 2*pi/lx * [0:round(nx/2), -nx/2+1:-1];
   kx=kx'*A; % wavenumber in x direction
   kx=(kx');
   ky = 2*pi/ly * [0:round(ny/2), -ny/2+1:-1];
   ky=ky'*A;% wavenumber in y direction
   kz = 2*pi/lz * [0:round(nz/2), -nz/2+1:-1];
  
   

   
