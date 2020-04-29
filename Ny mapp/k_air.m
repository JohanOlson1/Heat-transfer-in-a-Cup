function out = k_air(T)

% Värmekonduktivitet för luft, W/(m K)
%
% k=k_air(T), T i Kelvingrader

out = 0.0243 + 4.8e-5*(T-273) + 2.9e-7*(T-273)^2;
