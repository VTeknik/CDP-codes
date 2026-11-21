
% This function define coordinate of center of window in the the map 
% x and y are coordinate of each point in the grid.
% overlap is two adjacent overlap value.
function  [point_xy]=pointxy(x,y,win_l,overlap)

y1 = min(y)+win_l/2; % initial point in y direction
counter=1;
while true
   x1 = min(x)+win_l/2;% initial point in x direction
                if(y1>max(y)-win_l/4), break,end
         while true
                if(x1>max(x)-win_l/4), break,end
             xpoint(counter)=x1;
             ypoint(counter)=y1;
             x1=x1+(win_l-overlap);
             counter=counter+1;
          end
    y1=y1+(win_l-overlap);
end
point_xy = [xpoint' ypoint'];
save point_xy point_xy -ascii