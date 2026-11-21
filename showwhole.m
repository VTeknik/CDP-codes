     
function showwhole(x,y,point_xy)
 
        fig22=figure(22); % show win centers and all data points
        axis equal
               
            scatter(x,y,5,[.5 0 0],'filled') % plot initial ungrided data points
            hold on
            scatter(point_xy(:,1),point_xy(:,2),20,[0 1 0]) % plot win center coordinate
            hold off
            pause
        close(fig22)
    %--------------End show whole data and grid points---------------------
end