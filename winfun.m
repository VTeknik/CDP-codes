


function w =winfun(n,n2)

if nargin == 2;  
    w1 = winfun(n);
    w2 = winfun(n2);
    w = w1(:) * w2;
    return;
end; 
    
saved_name = 'kbeta';
s = load('kbeta.mat', saved_name);
kbeta = s.(saved_name);
u = window(@kaiser,n,kbeta);
% u = window(@hamming,n);
w = u(:).'; 

