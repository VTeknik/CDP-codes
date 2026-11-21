
function [kx,ky] = wavenumber(nx,ny,cs)

%    A=ones(1,nx);
%    kx = 2*pi/win_l * [linspace(0,nx/2,length(0:nx/2)),linspace((-nx/2)+1,-1,length(-nx/2+1:-1)) ];
%    kx=kx'*A;
%    kx=(kx');
%    ky = 2*pi/win_l * [linspace(0,ny/2,length(0:ny/2)),linspace((-ny/2)+1,-1,length(-ny/2+1:-1)) ];
%    ky=ky'*A;
 

N=nx;   
A=ones(1,N);
   kx = (2*pi/((N-1)*cs)) * [0:round(N/2), -(N/2)+1:-1]; % wave number
   kx=kx'*A;
   kx=(kx');
   ky = (2*pi/((N-1)*cs)) * [0:round(N/2), -(N/2)+1:-1];
   ky=ky'*A;
