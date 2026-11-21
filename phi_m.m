
function [phi_fft,k] = phi_m(nx,ny,nz,kx,ky,kz,z1,z2,beta)
cm = 10;
% direction cosines of magnetization;
mx = 0;
my = 0;
mz = 1;
% direction cosines of regional magnetic field;
fx = 0;
fy = 0;
fz = 1;
v = [nx,ny,nz];
M = normrnd(0,0.2,v); % Random Magnetization
M_fft = (fftn(M));
k = sqrt((kx.^2)+(ky.^2));% FFT transform of magnetization;

% calculation wavenumber and total anomaly in fourier domain
mag_k=0;
for p=1:nz
   for a=1:nx
       for b=1:ny
        
       if (k(a,b) == 0) 
            phi_fft(a,b) = 0;
        else
            thetam(a,b) = mz+i*((kx(a,b)*mx+ky(a,b)*my)/k(a,b));
            thetaf(a,b) = fz+i*(kx(a,b)*fx+ky(a,b)*fy)/k(a,b);
            k_xyz(a,b,p) = sqrt((kx(a,b)^2)+(ky(a,b)^2)+(kz(p)^2));
            M_fft_k(a,b) = M_fft(a,b,p)*(k_xyz(a,b,p)^(-beta/2.4));
            phi_fft(a,b) = 2*pi*cm*M_fft_k(a,b)...
            *thetam(a,b)*thetaf(a,b)*(exp(-k(a,b)*z1)-exp(-k(a,b)*z2));
        end
       end
    end
mag_k = mag_k+(phi_fft);
phi_fft = 0;
end
phi_fft = (mag_k);



