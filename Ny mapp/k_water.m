function out = k_water(T)

% Värmekonduktivitet för vatten, W/(m K)
%
% k=k_water(T), T i Kelvingrader

out = 0.55133+2.518e-3*(T-273)-1.22e-5*(T-273)^2;


