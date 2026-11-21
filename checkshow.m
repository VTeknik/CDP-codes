function [win_l,nn,beta,kbeta,cs] = checkshow(k_r,LOG_RAPS,phi_k1,zt,XI2,YI2,ZI,LONGW,LATW,MAG_W,...
     win_l,MAG_W0,nn,x,y,mag,point_xy,overlap,beta,kbeta,cs,mag_fft)


fig1 = figure(66); 
  clf(fig1)
  axes('position',[0  0  1  1],'Visible','off')
  set (fig1, 'Units', 'normalized', 'Position', [0,0,1,1]);
beta=beta;
kbeta=kbeta; 
cs = cs;
win_l = win_l;

subplot(2,2,1)
contourf(XI2,YI2,ZI,10,'LineColor','none');
hold on
axis square
xlabel('Long')
ylabel('Lat')
title('Whole aeromagnetic data and win')


rectangle('Position',[mean(mean(LONGW)), mean(mean(LATW)),win_l/111,win_l/111],'LineWidth',2,'LineStyle','-','EdgeColor','red');
shp = shaperead('Ostan.shp');
%extract Easting/Northing or Lat/long
x1 = extractfield(shp,'X');
y1 = extractfield(shp,'Y');
x1=x1';
y1=y1';
%show ascci data in map
mapshow(x1,y1)
hold off
  
subplot(2,2,2) 
plot(k_r, LOG_RAPS,'o','MarkerEdgeColor','k',...
                'MarkerFaceColor','g' );
hold on
plot(k_r, phi_k1,'LineWidth',1.5);
axis square
legend('Fitted');
xlabel('Wavenumber(Rad/Km)')
ylabel(' {\Phi_{B1D}}(K_H)')
title(['Top depth estimation for this win is : ',num2str(zt)])

% % helpdlg('Enter theory graph for comapring','Theory');
% zt_t=input('Theorical zt ');
% dz_t=input('Theorical dz ');
% beta_t=input('Theorical beta ');
% phi_t=theory(beta_t,zt_t,dz_t,c1,k_r);
% plot(k_r, phi_t,'-r','LineWidth',1.5);
% legend('Calculated','Fitted','Theory');
hold off



subplot(2,2,3) 
contourf(MAG_W0);hold on
title('Windowed data without effect of win function')
axis square
axis off
hold off

subplot(2,2,4) 
contourf(MAG_W);hold on
title('Windowed data with effect of win function')
axis square
axis off
hold off

%  figure(68)
%  contourf(abs(sqrt(mag_fft).^0.25),1000,'LineColor','none')
%  hold on
%  axis square
% axis off
% hold off
 %=================================continue or not?========================
  answer=input('Do you accept result? (y/n),  or go to optional win(p) ', 's');
  
  
while true
if answer == 'y'
    break
elseif answer == 'n'
    break
elseif answer == 'p'
    break
else
   disp(' Enter write answer ');
    answer=input('Do you accept result? (y/n),  or go to optional win(p) ', 's');
    continue
         
end
end

 if answer == 'y' 
    disp(' go to next win  ');
  
elseif answer=='n'
      win_l = input('Enter new win length ');
      beta = input('Enter new win beta ');
      kbeta = input('Enter new win keiser beta ');
      cs=input('Enter new cs ');
      save kbeta
     nn=nn-1;
  
   
 elseif answer=='p'
     fig2 = figure(67); 
  clf(fig2)
  axes('position',[0  0  1  1],'Visible','off')
  set (fig1, 'Units', 'normalized', 'Position', [0,0,1,1]);
  [X,Y,MAG]=griding(x,y,mag,1);
   contourf(X,Y,MAG,20);hold on

xlabel('Km')
ylabel('Km')
title('Fig(2):The whole data')
        [xn,yn] = ginput;
        pointx=find(point_xy(:,1)<=xn+(win_l-overlap) & point_xy(:,1)>=xn-(win_l-overlap));
        pointy=find(point_xy(:,2)<=yn+(win_l-overlap) & point_xy(:,2)>=yn-(win_l-overlap));
        point=intersect(pointx,pointy);
        nn=max((point));

 end

 %==============================End continue or not?=======================
end
