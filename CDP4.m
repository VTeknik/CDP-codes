clear all;
clc;
close all;
format long;

%==========================================================================
% The aim of the script is estimation Depth to Magnetic Basement(DMB), 
% avaraged susceptibilty and Curie Depth Point(CDP)using aeromagnetic data.
% Radially Avaraged Power Spectrum(RAPS)method is used for this purpose
% ========================Functins========================================
%  Functions:
%   ==>[x,y,mag,long,lat] = ldata  : loads data
%   ==>[point_xy] = pointxy(x,y,win_l,overlap) : defines window centers within the whole
%   data. 
%   ==>[win_l,overlap,beta,cs,dcs,per] = getpar  : gets parameters 
%   ==>[X,Y,MAG] = griding(x,y,mag,cs) : grid xyz format data
%   ==>[point_xy] = pointxy(x,y,win_l,overlap)  : find win centers coordinate
%   ==>showwhole(point_xy)  :  shows whole data and grid points
%   ==>[np, halfy,topout] = par(point_xy,cs) : Define some paremeters
%   ==>[Index_win,n_win_p] = windata(point_xy,nn,win_l,halfy,x,y,cs,per)
% widowing data
%   ==>   MAG_W = nanremove(MAG_W) : remove nan value of grid and replace with
%   mean value.
%   ==>winfunc = winfun(nx,ny) :creat window function for correctting Gibbs
%   phenomena
%   ==>[kx,ky] = wavenumber(nx,ny,cs); % define wavenumber
%   ==>[k_r,log_k_r,RAPS,LOG_RAPS] = rapspec(mag_fft,k)
% function that calculate Radial Average Power Spectrum
%   ==>rmsshow(zt_nc,rms_nc) % show rms 
%   ==> phi_fun : basic function furmulla

%   ==>checkshow(k_r,LOG_RAPS,phi_k1,zt,XI2,YI2,ZI,LONGW,LATW,MAG_W,mag_fft,win_l)
%checkshow function show results in each win
%   ==> showresults(topout,dcs); % show final results
%   ==>
%   ==>
%==========================================================================

[x,y,mag,long,lat] = ldata; %Load real data

% [x,y,mag,long,lat] = ldata_m; %Load model data data

[win_l,overlap,beta,cs,dcs,per,betaw] = getpar;%gets parameters from users

% [XI2,YI2,ZI] = griding(long,lat,mag,dcs); % grids whole magnetic data

[point_xy] = pointxy(x,y,win_l,overlap); % find win centers coordinate

% showwhole(point_xy) %show whole data and grid points

[np, halfy,topout] = par(point_xy,cs); %Define some paremeters


nn = 1; %counter
while true
 % if the program reach to last window then calculation would be terminated
 % np is number of windows
                      if(nn>=np),disp(' END of window '),break,end
                     
  % windowing data                   
[Index_win,n_win_p] = windata(point_xy,nn,win_l,halfy,x,y,cs,per);

 % in the following section if we did not have enough data in the win then go to next win 
                        if(length(Index_win) <= n_win_p && nn<=np)
                             disp(' Hey There isn,t enough data in this window ');
                             nn = nn+1;
                        continue
                        end
                        
         
   %windowing data
    XW = x(Index_win);
    YW = y(Index_win);
    LONGW = long(Index_win);
    LATW = lat(Index_win);
    MAG_W = mag(Index_win);
    
% scatter(XW,YW,14,[.5 0 0]) % shows windowed data 

%Reordering grid
MAG_W = nanremove(MAG_W); % remove nan values
[XW,YW,MAG_W] = griding(XW,YW,MAG_W,cs); % grid windowed data
MAG_W = nanremove(MAG_W);% remove nan values
[nx,ny] = size(MAG_W);
nxny = min(nx,ny);% produce equel dimension grid
MAG_W = MAG_W(1:nxny,1:nxny);XW = XW(1:nxny,1:nxny);YW = YW(1:nxny,1:nxny);
[nx,ny]=size(MAG_W);


                   if(nxny^2 <= n_win_p/1.5)
                             disp(' 22There isn,t enough data in this window ');
                             nn = nn+1;
                        continue
                        end
%=========================== Calculations==================================
winfunc = winfun(nx,ny); % produce win function for reducing Gipps Phenomenna
MAG_W = MAG_W.*winfunc;

[kx,ky] = wavenumber(nx,ny,cs); % define wavenumber

k = fftshift(sqrt((kx.^2)+(ky.^2)));

mag_fft = (fftshift(fft2(MAG_W))); % fft of windowed data

% % function that calculate Radial Average Power Spectrum
[k_r,log_k_r,RAPS,LOG_RAPS,km] = rapspec(mag_fft,k);

                       if(length(k_r) <=km/1.5)
                           disp(' 33 There isn,t enough data in this window ');
                             nn = nn+1;
                        continue
                        end

c1 = max(LOG_RAPS); % initial constant value

%-------------------------------------------------------------------------
% Define the range of fitting for each window
%we can remove some initial points from next calculation
% kmin = 0.05 ;kmax =0.85;
%  [kmin ,kmax]= kpick(k_r,LOG_RAPS);
% index_kr = find(kmin <= k_r & k_r <= kmax); %limit k_r values to selected value
k_r = k_r(2:end);   LOG_RAPS = LOG_RAPS(2:end);
%--------------------------------------------------------------------------

%-----------Loop for find best c1 constant and prameters-------------------
      nc=1; % Loop counter for calculating best c1 constant 
        while true   
save c1 c1 
c1_nc(nc)=c1;
%-------------------------------lsqcurvefit--------------------------------
           %[x,resnorm,residual] = lsqcurvefit(...) 
           %returns the value of the residual fun(x,xdata)-ydata at the solution x.
%Solve nonlinear curve-fitting (data-fitting) problems in least-squares sense
% starts at x0 and finds coefficients x to best fit the nonlinear function
%fun(x,xdata) to the data ydata (in the least-squares sense). ydata must be
%the same size as the vector (or matrix) F returned by fun.
[Cfs,resnorm,residual] = lsqcurvefit(@phi_fun, [5 25], k_r, LOG_RAPS, [0.0001 15], [20 50]);
%-------------------------------lsqcurvefit--------------------------------
zt_nc(nc) = Cfs(1);
dz_nc(nc) = Cfs(2);
resnorm_nc(nc) = resnorm;

rms_nc(nc)=sqrt(resnorm/length(k_r)); % calculate RMS for each fitting

              if(c1 <= min(LOG_RAPS) || zt_nc(nc)<0.02),disp(' End c1 finding '),break,end
nc=nc+1;
c1=c1-0.5;
        end
        
%         rmsshow(zt_nc,rms_nc) % show rms 
        
      index_nc=find(rms_nc == min(rms_nc));
      zt = zt_nc(index_nc); % best fitted parameters
      dz = dz_nc(index_nc);
      c1 = c1_nc(index_nc);
      resnormout = resnorm_nc(index_nc);
    
      rmsout = rms_nc(index_nc);
      zb = zt+dz;
    
 phi_k1=theory(beta,zt,dz,c1,k_r); % RAPS graph 
%-----------End Loop for find best c1 constant and prameters---------------

% checkshow function show results in each win for check and stop program by
% press any button
%  checkshow(k_r,LOG_RAPS,phi_k1,zt,XI2,YI2,ZI,LONGW,LATW,MAG_W,mag_fft,win_l)


nn=nn+1; %next window

%save result
top_win=[mean(mean(XW)) mean(mean(YW)) mean(mean(LONGW)) mean(mean(LATW)) zt dz c1 rmsout resnormout];
topout= [topout; top_win];
helpdlg({int2str(nn) 'from' int2str(np)});
end

outname = ['W' num2str(win_l) 'B' num2str(beta) 'Op' num2str(overlap*(100/win_l)) 'Bw' num2str(betaw) 'CS' num2str(cs) ];
outname = strrep(outname,'.', 'p');
save (outname, 'topout', '-ASCII')

% showresults(topout,dcs); % show final results








