function [beta,z1,lz,cs]=model
length_m = input('input model Length (in KM):  ');
%==========================================================================
% define Parameters
%==========================================================================
% lx and ly length of grid in x and y direction
lx = length_m;%input('input length of window in x and y directions (in KM):  '); 
ly = lx;
% nx and ny number of samples in x and y directions;
cs = 1; % cell size must be one because of converting to XYZ format
nx = round(lx/cs); %input('input number of samples in x and y directions:  '); 
ny = nx;
z1 = input('input model top depth(z1)(in KM):  '); 
z2 = input('input model bottom depth(z2)(in KM):  '); 
beta = input('input model beta:  ');
lz = (z2-z1); %thickness of slab
nz=round(lz/cs);% number of sample points in Z direction


[kxh,kyh,kzh] = wavenumber_m(nx,ny,nz,lx,ly,lz); % define wavenumber
% calculation of wave number and total anomaly in fourier domain 
[phi_fft,k] = phi_m(nx,ny,nz,kxh,kyh,kzh,z1,z2,beta);
total = ifft2((phi_fft));

%------------------Export in XYZ format-----------------------------------
nc=1;
[nx,ny]=size(total);
[XI,YI] = meshgrid(linspace(1,lx,nx),linspace(1,ly,ny));
% convert total value to XYZ format.
for i=1:nx
    for j=1:ny
        xout(nc)=XI(i,j);
        yout(nc)=YI(i,j);
        zout(nc)=total(i,j);
        nc=nc+1;
    end
end
 zout = zout';
 xout = xout';
 yout = yout';
%  [XI2,YI2,ZI]=griding(xout,yout,zout,cs);
%  figure(01)
% contourf(XI,YI,real(total));
%  figure(02)
% contourf(XI2,YI2,real(ZI));
% figure(3) % compare difrence xyz format with early grided format(total)
% contourf(XI2,YI2,real(ZI-total));
model_p = [xout yout zout];
save  model_p model_p -ascii
%------------------------ End Export in XYZ format-------------------------









