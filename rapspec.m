%==========================*******************=============================
% rapspec calculate Radial Avrage of Power Spectrum and other grided data
% variable phi_fft is fft of input magnetic field phi
% variable k is wavenumber
%==========================*******************=============================

function [k_r,log_k_r,RAPS,LOG_RAPS,km]= rapspec(mag_fft,k)

power = abs(mag_fft.^2.0);   % power of input magnetic field phi
 
[m,n] = size(power);   % finding the size of input field 

center = ((m+1)/2); %matrix is square , so use m = n

% constructing grid for number of cells.
[i,j] = meshgrid(1:m,1:n);
% converting 2D grids to a long 1D one.
i = i(:); j = j(:);

% Calculating  distance of grid's center to each point, dist,
dist = sqrt((i-center).^2 + (j-center).^2);
dist_step = sqrt(2)/2;

% Now we convert power to 1D version.
power_1D = power(:);
% sort wavenumber
k_1D = k(:);

distance = min(dist); 

% helpdlg(int2str(floor((m/2)/dist_step)),'floor((m/2)/dist_step');
% pause
km =floor((m/2)/dist_step);
for kk = 1:km
    if(distance > (m/2)), break,end % If RAPS calculation be out of win then calculation break
    index = find(dist >= distance & dist <= distance+dist_step);
    
%    if kk==1    
%    index = find(dist>=1 & dist<=sqrt(2));
%    end
%    circle([center center],distance,500, '-')

 indexk = index;
   LOG_RAPS(kk) = (real(mean(log(power_1D(index)))));
   RAPS(kk) = (real(mean((power_1D(index))))); 
   k_r(kk) = mean((k_1D((index))));
   log_k_r(kk) = real(LOG_RAPS(kk)-(mean(2.*(log(k_1D(indexk))))));
   
   distance = distance+dist_step; 
end
% helpdlg(int2str(length(k_r)),'length(k_r)');
% index_kr = find(k_r < 0.41);
% helpdlg(int2str(length(index_kr)),'index_kr');
% pause
%,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

nf1=find((LOG_RAPS)==-Inf);
nf2=find(isnan(k_r));
nf3=find(isnan(LOG_RAPS));
nf=unique([nf1 nf2 nf3]);
% helpdlg(int2str(nf),'nf'); 
% pause
k_r(nf)=[]; log_k_r(nf)=[]; LOG_RAPS(nf)=[]; 

% % In the following codes we want to correct outline points with  
% mend=5;
% for mm=1:mend
%     if mm==1
%         moderaps=[LOG_RAPS(mm),LOG_RAPS(mm),LOG_RAPS(mm+1)];
%          LOG_RAPS1(mm)=median(moderaps);
%          continue
%     end
%     
%       moderaps=[LOG_RAPS(mm-1),LOG_RAPS(mm),LOG_RAPS(mm+1)];  
%  LOG_RAPS1(mm)=median(moderaps); 
% end
% LOG_RAPS(1:mend)=LOG_RAPS1(1:mend);
 
