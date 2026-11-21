function [kmin ,kmax]= kpick(k_r,LOG_RAPS)
 fig2 = figure(67); 
  clf(fig2)
  axes('position',[0.1  0.1  0.6  0.85],'Visible','off')
  set (fig2, 'Units', 'normalized', 'Position', [0.01,0.01,.9,0.9]);
  
  plot(k_r, LOG_RAPS,'o','MarkerEdgeColor','k',...
                'MarkerFaceColor','g' );
                        hold on
  
  disp(' pick k minimum  ');
[kmin,RAPSmin] = ginput(1);
line([kmin kmin], ylim);
disp(' pick k maximum  ');
[kmax,RAPSmax] = ginput(1);
line([kmax kmax], ylim);
% close(fig2)
end