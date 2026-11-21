function [phi_t , ierr] = theory(beta,zt_t,dz_t,c1,k_r)

a1 = sqrt(pi)/gamma(1+(beta/2));
a2 = (cosh(k_r.*dz_t)/2).*gamma((1+beta)/2);
[K] =besselk((1+beta)/2,k_r.*dz_t);
a3 = K.*((k_r.*dz_t/2).^((1+beta)/2));

phi_t=c1-(2.*zt_t.*k_r)-((beta-1).*log(k_r))+...
(-k_r.*dz_t)+log(a1.*(a2-a3));