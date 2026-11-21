function rmsshow(zt_nc,rms_nc)
fig11= figure(11);
plot(zt_nc,rms_nc,'ro' );hold on
plot(zt_nc,rms_nc)
xlabel('Zt')
ylabel('RMS')
title('Best RMS')
hold off
 pause
 close(fig11)
end