  % windowing data                   
  function [Index_win,n_win_p] = windata(point_xy,nn,win_l,halfy,x,y,cs,per)
   % Index_win variable is index of data points that located in nn,th window  
   
   Index_winx = find(round(point_xy(nn,1)-(win_l/2))-halfy<=x & x<=round(point_xy(nn,1)+(win_l/2))+halfy);
   Index_winy = find(round(point_xy(nn,2)-(win_l/2))-halfy<=y & y<=round(point_xy(nn,2)+(win_l/2))+halfy);
   Index_win = intersect(Index_winx,Index_winy); % Find set intersection of two vectors Index_winx and Index_winy
    
       %--------- define min data number in each window--------------------
       nx_win = round(win_l/cs);
       ny_win = nx_win;
       n_win = nx_win*ny_win; %  Theorical min data number at each window with length of win_l
       n_win_p = round(n_win*(per)); % min data numbers in each win that accepted
  end