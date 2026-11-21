function phi_k = phi_fun(pr,k_r)
zt=pr(1);
dz=pr(2);

saved_name0 = 'c1';
s0 = load('c1.mat', saved_name0);
c1 = s0.(saved_name0);

saved_name = 'beta';
s = load('beta.mat', saved_name);
beta = s.(saved_name);

phi_k=(c1-(2.*zt.*k_r)-((beta-1).*log(k_r)))+...
((-k_r.*dz)+log((sqrt(pi)/gamma(1+(beta/2))).*(((cosh(k_r.*dz)/2).*gamma((1+beta)/2))...
    -besselk((1+beta)/2,k_r.*dz).*((k_r.*dz/2).^((1+beta)/2)))));

