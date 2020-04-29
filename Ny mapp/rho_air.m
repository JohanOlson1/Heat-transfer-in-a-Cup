function out = rho_air(T)

% Densitet för luft, kg/m3
%
% rho=rho_air(T), T i Kelvingrader

Ptot  = 101325;
M_air = 0.0286;
R     = 8.3145;

out = M_air*Ptot/(R*T);
