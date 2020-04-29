function out = k_air(T)

% V�rmekonduktivitet f�r luft, W/(m K)
%
% k=k_air(T), T i Kelvingrader

out = 0.0243 + 4.8e-5*(T-273) + 2.9e-7*(T-273)^2;
