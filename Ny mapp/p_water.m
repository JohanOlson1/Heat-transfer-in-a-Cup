function out = p_water(T)

% �ngtryck f�r vatten, Pa
%
% p=p_water(T), T i Kelvingrader

out = 19860*exp(-42504/8.3145*(1/T-1/333));